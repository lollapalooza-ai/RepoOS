import llvmlite.ir as ir
import llvmlite.binding as llvm
import ctypes
from component2_smt import VerifiedMLIR

llvm.initialize()
llvm.initialize_native_target()
llvm.initialize_native_asmprinter()

class PolyKernelJIT:
    def __init__(self):
        self.target_machine = llvm.Target.from_default_triple().create_target_machine()
        self.empty_mod = llvm.parse_assembly("")
        self.engine = llvm.create_mcjit_compiler(self.empty_mod, self.target_machine)

    def incremental_compile(self, func_name: str, mlir_data: VerifiedMLIR, ctypes_signature, arg_count: int):
        module = ir.Module(name=f"module_{func_name}")
        
        # MILESTONE 2.0: Entry arguments are now (char* buffer, int32 length)
        byte_ptr_type = ir.PointerType(ir.IntType(8))
        func_type = ir.FunctionType(ir.DoubleType(), [byte_ptr_type, ir.IntType(32)])
        func = ir.Function(module, func_type, name=func_name)
        
        # Two-Pass Block Allocation
        blocks = {"entry": func.append_basic_block(name="entry")}
        
        # Pass 1: Discover all labels
        for instruction in mlir_data.operations:
            if instruction.op == "label":
                label_name = instruction.args[0]
                blocks[label_name] = func.append_basic_block(name=label_name)
                
        builder = ir.IRBuilder(blocks["entry"])
        
        # Map initial inputs
        variables = {"raw_buffer": func.args[0], "buffer_len": func.args[1]}
        
        # Allocate local memory arrays
        for alloc in mlir_data.memory_allocations:
            var_type = ir.ArrayType(ir.DoubleType(), alloc.size)
            variables[alloc.name] = builder.alloca(var_type, name=alloc.name)

        def resolve_arg(arg_str):
            if arg_str in variables: return variables[arg_str]
            if arg_str in blocks: return blocks[arg_str] # Return block for branches
            try: return ir.Constant(ir.DoubleType(), float(arg_str))
            except ValueError: return ir.Constant(ir.DoubleType(), 0.0)

        last_res = None
        
        # Pass 2: Compile instructions
        for instruction in mlir_data.operations:
            op = instruction.op
            args = instruction.args
            
            # Robust Argument Extraction
            def get_arg(idx, default="0.0"):
                return args[idx] if len(args) > idx else default

            if op == "label":
                # Switch builder focus to the new block
                builder.position_at_end(blocks[args[0]])
                continue
            
            elif op == "br":
                # Handle Branching
                if len(args) == 1:
                    # Unconditional branch: br label
                    builder.branch(resolve_arg(args[0]))
                elif len(args) == 3:
                    # Conditional branch: br cond, true_label, false_label
                    # cond might be stored as double (1.0/0.0), cast to i1
                    val = resolve_arg(args[0])
                    if val.type == ir.DoubleType():
                        cond = builder.fcmp_ordered('>', val, ir.Constant(ir.DoubleType(), 0.5))
                    else:
                        cond = builder.trunc(val, ir.IntType(1))
                    builder.cbranch(cond, resolve_arg(args[1]), resolve_arg(args[2]))
                last_res = None
                
            elif op == "add":
                last_res = builder.fadd(resolve_arg(get_arg(0)), resolve_arg(get_arg(1)), name=instruction.target_var)
            elif op == "sub":
                last_res = builder.fsub(resolve_arg(get_arg(0)), resolve_arg(get_arg(1)), name=instruction.target_var)
            elif op == "mul":
                last_res = builder.fmul(resolve_arg(get_arg(0)), resolve_arg(get_arg(1)), name=instruction.target_var)
            elif op == "div":
                last_res = builder.fdiv(resolve_arg(get_arg(0)), resolve_arg(get_arg(1)), name=instruction.target_var)
            elif op == "cmp_eq":
                cmp = builder.fcmp_ordered('==', resolve_arg(get_arg(0)), resolve_arg(get_arg(1)), name=f"{instruction.target_var}_cmp")
                last_res = builder.uitofp(cmp, ir.DoubleType(), name=instruction.target_var)
            elif op == "select":
                cond_i1 = builder.fcmp_ordered('>', resolve_arg(get_arg(0)), ir.Constant(ir.DoubleType(), 0.5))
                last_res = builder.select(cond_i1, resolve_arg(get_arg(1)), resolve_arg(get_arg(2)), name=instruction.target_var)
            elif op == "load":
                base = resolve_arg(get_arg(0))
                if isinstance(base.type, ir.PointerType) and isinstance(base.type.pointee, ir.ArrayType):
                    ptr = builder.gep(base, [ir.Constant(ir.IntType(32), 0), ir.Constant(ir.IntType(32), 0)])
                    last_res = builder.load(ptr, name=instruction.target_var)
                else:
                    last_res = builder.load(base, name=instruction.target_var)
            elif op == "store":
                builder.store(resolve_arg(get_arg(0)), resolve_arg(get_arg(1)))
                last_res = None
            elif op == "gep":
                base = resolve_arg(get_arg(0))
                idx = builder.fptosi(resolve_arg(get_arg(1)), ir.IntType(32))
                # Handle both array pointers and raw byte pointers
                if isinstance(base.type.pointee, ir.ArrayType):
                    last_res = builder.gep(base, [ir.Constant(ir.IntType(32), 0), idx], name=instruction.target_var)
                else:
                    last_res = builder.gep(base, [idx], name=instruction.target_var)
            elif op == "icmp":
                cmp_op = get_arg(0)
                lhs = get_arg(1)
                rhs = get_arg(2)
                if cmp_op not in ['==', '!=', '<', '<=', '>', '>=']:
                    rhs = lhs
                    lhs = cmp_op
                    cmp_op = '=='
                cmp = builder.fcmp_ordered(cmp_op, resolve_arg(lhs), resolve_arg(rhs), name=instruction.target_var)
                last_res = builder.uitofp(cmp, ir.DoubleType())
            
            if instruction.target_var and last_res:
                variables[instruction.target_var] = last_res
            
        # Ensure block has a terminator
        if not builder.block.is_terminated:
            if last_res is None or isinstance(last_res.type, ir.VoidType):
                last_res = ir.Constant(ir.DoubleType(), 0.0)
            elif not isinstance(last_res.type, ir.DoubleType):
                try: last_res = builder.sitofp(last_res, ir.DoubleType())
                except: last_res = ir.Constant(ir.DoubleType(), 0.0)
            builder.ret(last_res)
        
        llmod = llvm.parse_assembly(str(module))
        self.engine.add_module(llmod)
        self.engine.finalize_object()
        
        func_ptr = self.engine.get_function_address(func_name)
        return ctypes_signature(func_ptr)
