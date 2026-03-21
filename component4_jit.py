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
        
        arg_types = [ir.DoubleType()] * arg_count
        func_type = ir.FunctionType(ir.DoubleType(), arg_types)
        func = ir.Function(module, func_type, name=func_name)
        
        block = func.append_basic_block(name="entry")
        builder = ir.IRBuilder(block)
        
        variables = {f"arg{i}": func.args[i] for i in range(arg_count)}
        last_res = None
        
        # Memory Allocations
        for alloc in mlir_data.memory_allocations:
            # For MVP, we use alloca for simplicity
            var_type = ir.ArrayType(ir.DoubleType(), alloc.size)
            variables[alloc.name] = builder.alloca(var_type, name=alloc.name)

        def resolve_arg(arg_str):
            if arg_str in variables:
                return variables[arg_str]
            try:
                return ir.Constant(ir.DoubleType(), float(arg_str))
            except ValueError:
                return ir.Constant(ir.DoubleType(), 0.0)

        for instruction in mlir_data.operations:
            op = instruction.op
            args = instruction.args
            
            # Robust Argument Extraction
            def get_arg(idx, default="0.0"):
                return args[idx] if len(args) > idx else default

            if op == "add":
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
                # If loading from an allocation, we must index into it first
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
                last_res = builder.gep(base, [ir.Constant(ir.IntType(32), 0), idx], name=instruction.target_var)
            elif op == "icmp":
                # Expects: [op, lhs, rhs]
                # If AI only sends 2 args, it likely missed the 'op'. Default to '=='
                cmp_op = get_arg(0)
                lhs = get_arg(1)
                rhs = get_arg(2)
                
                if cmp_op not in ['==', '!=', '<', '<=', '>', '>=']:
                    # Re-align: [lhs, rhs] with default '=='
                    rhs = lhs
                    lhs = cmp_op
                    cmp_op = '=='
                
                cmp = builder.fcmp_ordered(cmp_op, resolve_arg(lhs), resolve_arg(rhs), name=instruction.target_var)
                last_res = builder.uitofp(cmp, ir.DoubleType())
            
            if instruction.target_var and last_res:
                variables[instruction.target_var] = last_res
            
        if last_res is None or isinstance(last_res.type, ir.VoidType):
            last_res = ir.Constant(ir.DoubleType(), 0.0)
        elif not isinstance(last_res.type, ir.DoubleType):
            # Try to cast to double if it's not
            try:
                last_res = builder.sitofp(last_res, ir.DoubleType())
            except:
                last_res = ir.Constant(ir.DoubleType(), 0.0)
            
        builder.ret(last_res)
        
        llmod = llvm.parse_assembly(str(module))
        self.engine.add_module(llmod)
        self.engine.finalize_object()
        
        func_ptr = self.engine.get_function_address(func_name)
        return ctypes_signature(func_ptr)
