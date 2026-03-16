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

    def incremental_compile(self, func_name: str, mlir_data: VerifiedMLIR, ctypes_signature):
        module = ir.Module(name=f"module_{func_name}")
        func_type = ir.FunctionType(ir.DoubleType(), [ir.DoubleType(), ir.DoubleType()])
        func = ir.Function(module, func_type, name=func_name)
        
        block = func.append_basic_block(name="entry")
        builder = ir.IRBuilder(block)
        
        variables = {"arg1": func.args[0], "arg2": func.args[1]}
        last_res = None
        
        def resolve_arg(arg_str):
            if arg_str in variables:
                return variables[arg_str]
            try:
                return ir.Constant(ir.DoubleType(), float(arg_str))
            except ValueError:
                return ir.Constant(ir.DoubleType(), 0.0)

        for instruction in mlir_data.operations:
            op = instruction.op
            
            if op == "cmp_eq":
                v1 = resolve_arg(instruction.args[0])
                v2 = resolve_arg(instruction.args[1])
                # returns i1
                cmp = builder.fcmp_ordered('==', v1, v2, name=f"{instruction.target_var}_cmp")
                # cast i1 to double (1.0 or 0.0)
                last_res = builder.uitofp(cmp, ir.DoubleType(), name=instruction.target_var)
            elif op == "select":
                cond_val = resolve_arg(instruction.args[0])
                true_val = resolve_arg(instruction.args[1])
                false_val = resolve_arg(instruction.args[2])
                # cast double back to i1 for select
                # 1.0 is true, anything else false? Let's check > 0.5
                cond_i1 = builder.fcmp_ordered('>', cond_val, ir.Constant(ir.DoubleType(), 0.5), name=f"{instruction.target_var}_cond")
                last_res = builder.select(cond_i1, true_val, false_val, name=instruction.target_var)
            else:
                v1 = resolve_arg(instruction.args[0])
                v2 = resolve_arg(instruction.args[1])
                if op == "add": last_res = builder.fadd(v1, v2, name=instruction.target_var)
                elif op == "sub": last_res = builder.fsub(v1, v2, name=instruction.target_var)
                elif op == "mul": last_res = builder.fmul(v1, v2, name=instruction.target_var)
                elif op == "div": last_res = builder.fdiv(v1, v2, name=instruction.target_var)
            
            variables[instruction.target_var] = last_res
            
        if last_res is None:
            last_res = ir.Constant(ir.DoubleType(), 0.0)
            
        builder.ret(last_res)
        
        llmod = llvm.parse_assembly(str(module))
        self.engine.add_module(llmod)
        self.engine.finalize_object()
        
        func_ptr = self.engine.get_function_address(func_name)
        return ctypes_signature(func_ptr)
