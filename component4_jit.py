import llvmlite.ir as ir
import llvmlite.binding as llvm
import ctypes
from component2_smt import VerifiedMLIR

llvm.initialize()
llvm.initialize_native_target()
llvm.initialize_native_asmprinter()

# Milestone 3.0: Dynamic Type Mapper
TYPE_MAP = {
    'int': (ir.IntType(32), ctypes.c_int32),
    'float': (ir.DoubleType(), ctypes.c_double),
    'double': (ir.DoubleType(), ctypes.c_double),
    'str': (ir.PointerType(ir.IntType(8)), ctypes.c_char_p), # String View Pointer
    'bool': (ir.IntType(1), ctypes.c_bool),
    'void': (ir.VoidType(), None)
}

def map_python_signature_to_llvm(type_hints: dict):
    """
    Maps Python type hints (from Neo4j or inspect) to LLVM and Ctypes.
    """
    ir_args = []
    ctypes_args = []
    for arg_name, type_str in type_hints.items():
        # Default to double if type is unknown (MVP)
        ir_t, c_t = TYPE_MAP.get(type_str.lower(), TYPE_MAP['double'])
        ir_args.append(ir_t)
        ctypes_args.append(c_t)
    return ir_args, ctypes_args

class PolyKernelJIT:
    def __init__(self):
        self.target_machine = llvm.Target.from_default_triple().create_target_machine()
        self.empty_mod = llvm.parse_assembly("")
        self.engine = llvm.create_mcjit_compiler(self.empty_mod, self.target_machine)

    def incremental_compile(self, func_name: str, mlir_data: VerifiedMLIR, ctypes_signature, arg_count: int, ir_arg_types=None):
        module = ir.Module(name=f"module_{func_name}")
        
        # Declare external strcmp (C standard library)
        strcmp_t = ir.FunctionType(ir.IntType(32), [ir.PointerType(ir.IntType(8)), ir.PointerType(ir.IntType(8))])
        strcmp_f = ir.Function(module, strcmp_t, name="strcmp")
        if ir_arg_types:
            func_type = ir.FunctionType(ir.DoubleType(), ir_arg_types)
        elif arg_count == 0 and any(m.name == "raw_buffer" for m in mlir_data.memory_allocations):
            # Special case for Zero-Copy FSM Scanner
            byte_ptr_type = ir.PointerType(ir.IntType(8))
            func_type = ir.FunctionType(ir.DoubleType(), [byte_ptr_type, ir.IntType(32)])
        else:
            # Fallback to all doubles
            arg_types = [ir.DoubleType()] * arg_count
            func_type = ir.FunctionType(ir.DoubleType(), arg_types)
            
        func = ir.Function(module, func_type, name=func_name)
        
        # Two-Pass Block Allocation
        blocks = {"entry": func.append_basic_block(name="entry")}
        for instruction in mlir_data.operations:
            if instruction.op == "label":
                label_name = instruction.args[0]
                blocks[label_name] = func.append_basic_block(name=label_name)
                
        builder = ir.IRBuilder(blocks["entry"])
        
        # Variable Registry
        variables = {}
        if arg_count == 0 and any(m.name == "raw_buffer" for m in mlir_data.memory_allocations):
            variables["raw_buffer"] = func.args[0]
            variables["buffer_len"] = func.args[1]
        else:
            for i in range(len(func.args)):
                variables[f"arg{i}"] = func.args[i]
        
        # Allocate local memory arrays
        for alloc in mlir_data.memory_allocations:
            if alloc.name != "raw_buffer":
                # Assume double arrays for now, or match type if we expand ISA
                var_type = ir.ArrayType(ir.DoubleType(), alloc.size)
                variables[alloc.name] = builder.alloca(var_type, name=alloc.name)

        def resolve_arg(arg_str):
            if arg_str in variables: return variables[arg_str]
            if arg_str in blocks: return blocks[arg_str]
            try: return ir.Constant(ir.DoubleType(), float(arg_str))
            except ValueError: return ir.Constant(ir.DoubleType(), 0.0)

        last_res = None
        
        # Pass 2: Compile instructions
        for instruction in mlir_data.operations:
            op = instruction.op
            args = instruction.args
            
            def get_arg(idx, default="0.0"):
                return args[idx] if len(args) > idx else default

            if op == "label":
                builder.position_at_end(blocks[args[0]])
                continue
            
            elif op == "br":
                if len(args) == 1:
                    builder.branch(resolve_arg(args[0]))
                elif len(args) == 3:
                    val = resolve_arg(args[0])
                    # Handle i1 or double condition
                    if val.type == ir.IntType(1):
                        cond = val
                    else:
                        cond = builder.fcmp_ordered('>', val, ir.Constant(ir.DoubleType(), 0.5))
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
                v0 = resolve_arg(get_arg(0))
                cond_i1 = v0 if v0.type == ir.IntType(1) else builder.fcmp_ordered('>', v0, ir.Constant(ir.DoubleType(), 0.5))
                last_res = builder.select(cond_i1, resolve_arg(get_arg(1)), resolve_arg(get_arg(2)), name=instruction.target_var)
            elif op == "load":
                base = resolve_arg(get_arg(0))
                # Handle different pointer types
                if isinstance(base.type, ir.PointerType):
                    if isinstance(base.type.pointee, ir.ArrayType):
                        ptr = builder.gep(base, [ir.Constant(ir.IntType(32), 0), ir.Constant(ir.IntType(32), 0)])
                        last_res = builder.load(ptr, name=instruction.target_var)
                    else:
                        last_res = builder.load(base, name=instruction.target_var)
                else:
                    last_res = base # Fallback
            elif op == "store":
                builder.store(resolve_arg(get_arg(0)), resolve_arg(get_arg(1)))
                last_res = None
            elif op == "gep":
                base = resolve_arg(get_arg(0))
                idx_val = builder.fptosi(resolve_arg(get_arg(1)), ir.IntType(32)) if resolve_arg(get_arg(1)).type == ir.DoubleType() else resolve_arg(get_arg(1))
                if isinstance(base.type.pointee, ir.ArrayType):
                    last_res = builder.gep(base, [ir.Constant(ir.IntType(32), 0), idx_val], name=instruction.target_var)
                else:
                    last_res = builder.gep(base, [idx_val], name=instruction.target_var)
            elif op == "icmp":
                cmp_op = get_arg(0)
                lhs, rhs = resolve_arg(get_arg(1)), resolve_arg(get_arg(2))
                # Handle integer vs float comparison
                if lhs.type == ir.IntType(8) or lhs.type == ir.IntType(32):
                    cmp = builder.icmp_unsigned(cmp_op if cmp_op != '==' else '==', lhs, rhs, name=instruction.target_var)
                else:
                    cmp = builder.fcmp_ordered(cmp_op, lhs, rhs, name=instruction.target_var)
                last_res = builder.uitofp(cmp, ir.DoubleType())
            
            elif op == "alloc_struct":
                # args: [name, size]
                size = int(float(get_arg(1, "8")))
                var_type = ir.ArrayType(ir.IntType(8), size)
                variables[get_arg(0)] = builder.alloca(var_type, name=get_arg(0))
                last_res = variables[get_arg(0)]
            
            elif op == "string_view_ptr":
                # args: [buffer, offset, length]
                base = resolve_arg(get_arg(0))
                offset = resolve_arg(get_arg(1))
                if offset.type == ir.DoubleType():
                    offset = builder.fptosi(offset, ir.IntType(32))
                # Ensure base is a pointer
                if not isinstance(base.type, ir.PointerType):
                    last_res = ir.Constant(ir.DoubleType(), 0.0)
                else:
                    last_res = builder.gep(base, [offset], name=instruction.target_var)
            
            elif op == "ffi_call":
                # placeholder: return 0.0 for now
                last_res = ir.Constant(ir.DoubleType(), 0.0)
            
            elif op == "strcmp":
                # args: [ptr1, ptr2_or_literal]
                p1 = resolve_arg(get_arg(0))
                p2_raw = get_arg(1)
                
                # If p2 is a literal, create a global string constant
                if not p2_raw in variables and not p2_raw.replace('.','').isdigit():
                    s_val = bytes(p2_raw, "utf8") + b"\0"
                    s_type = ir.ArrayType(ir.IntType(8), len(s_val))
                    global_s = ir.GlobalVariable(module, s_type, name=f"str_{hash(p2_raw)}")
                    global_s.initializer = ir.Constant(s_type, bytearray(s_val))
                    global_s.linkage = 'internal'
                    p2 = builder.gep(global_s, [ir.Constant(ir.IntType(32), 0), ir.Constant(ir.IntType(32), 0)])
                else:
                    p2 = resolve_arg(p2_raw)
                
                # Ensure we have i8* pointers
                if not isinstance(p1.type, ir.PointerType):
                     # Maybe it's a double that the AI thinks is a pointer
                     last_res = ir.Constant(ir.DoubleType(), 0.0)
                else:
                    res_i32 = builder.call(strcmp_f, [p1, p2])
                    # 0 means equal. Convert to float 1.0 (True) if 0, else 0.0
                    is_eq = builder.icmp_unsigned('==', res_i32, ir.Constant(ir.IntType(32), 0))
                    last_res = builder.uitofp(is_eq, ir.DoubleType(), name=instruction.target_var)

            if instruction.target_var and last_res:
                variables[instruction.target_var] = last_res
            
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
