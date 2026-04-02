import llvmlite.ir as ir
import llvmlite.binding as llvm
import ctypes
from component2_smt import VerifiedMLIR

# Global registry to keep LLVM objects alive and avoid GC-related segfaults
_KEEP_ALIVE = []

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

# Operator Map for icmp/fcmp
OP_MAP = {
    'eq': '==',
    'ne': '!=',
    'gt': '>',
    'lt': '<',
    'ge': '>=',
    'le': '<=',
    '==': '==',
    '!=': '!=',
    '>': '>',
    '<': '<',
    '>=': '>=',
    '<=': '<='
}

def map_python_signature_to_llvm(type_hints: dict):
    ir_args = []
    ctypes_args = []
    for arg_name, type_str in type_hints.items():
        ir_t, c_t = TYPE_MAP.get(type_str.lower(), TYPE_MAP['double'])
        ir_args.append(ir_t)
        ctypes_args.append(c_t)
    return ir_args, ctypes_args

class PolyKernelJIT:
    def __init__(self):
        pass

    def incremental_compile(self, func_name: str, mlir_data: VerifiedMLIR, ctypes_signature, arg_count: int, ir_arg_types=None):
        module = ir.Module(name=f"module_{func_name}")
        target = llvm.Target.from_default_triple()
        target_machine = target.create_target_machine()
        module.triple = target_machine.triple
        
        if ir_arg_types:
            func_type = ir.FunctionType(ir.DoubleType(), ir_arg_types)
        elif arg_count == 0 and any(m.name == "raw_buffer" for m in mlir_data.memory_allocations):
            byte_ptr_type = ir.PointerType(ir.IntType(8))
            func_type = ir.FunctionType(ir.DoubleType(), [byte_ptr_type, ir.IntType(32)])
        else:
            arg_types = [ir.DoubleType()] * arg_count
            func_type = ir.FunctionType(ir.DoubleType(), arg_types)
            
        func = ir.Function(module, func_type, name=func_name)
        
        strcmp_f = None
        if any(op.op == "strcmp" for op in mlir_data.operations):
            strcmp_t = ir.FunctionType(ir.IntType(32), [ir.PointerType(ir.IntType(8)), ir.PointerType(ir.IntType(8))])
            strcmp_f = ir.Function(module, strcmp_t, name="strcmp")
        
        # Pass 1: Block Identification
        blocks = {}
        # We MUST ensure the entry block is the first one appended to the function.
        # If the first operation is a label, use that as the entry.
        ops = mlir_data.operations
        if ops and ops[0].op == "label":
            entry_name = ops[0].args[0]
            blocks[entry_name] = func.append_basic_block(name=entry_name)
        else:
            blocks["entry"] = func.append_basic_block(name="entry")

        for op in ops:
            if op.op == "label":
                name = op.args[0]
                if name not in blocks:
                    blocks[name] = func.append_basic_block(name=name)
        
        # Determine the initial builder block
        initial_block_name = ops[0].args[0] if (ops and ops[0].op == "label") else "entry"
        builder = ir.IRBuilder(blocks[initial_block_name])
        
        variables = {} # Maps names to ALLOCATED memory slots (pointers)
        
        # 1. Arguments (copy to stack for mutability)
        if arg_count == 0 and any(m.name == "raw_buffer" for m in mlir_data.memory_allocations):
            variables["raw_buffer"] = builder.alloca(ir.PointerType(ir.IntType(8)), name="raw_buffer_slot")
            builder.store(func.args[0], variables["raw_buffer"])
            variables["buffer_len"] = builder.alloca(ir.IntType(32), name="buffer_len_slot")
            builder.store(func.args[1], variables["buffer_len"])
        else:
            for i in range(len(func.args)):
                arg_name = f"arg{i}"
                slot = builder.alloca(func.args[i].type, name=f"{arg_name}_slot")
                builder.store(func.args[i], slot)
                variables[arg_name] = slot
        
        # 2. Local Memory (Arrays)
        for alloc in mlir_data.memory_allocations:
            if alloc.name != "raw_buffer" and alloc.name not in variables:
                var_type = ir.ArrayType(ir.DoubleType(), alloc.size)
                variables[alloc.name] = builder.alloca(var_type, name=alloc.name)

        def resolve_arg(arg_str):
            if arg_str in variables:
                slot = variables[arg_str]
                if isinstance(slot.type.pointee, ir.ArrayType):
                    return slot # Arrays stay as pointers for GEP
                return builder.load(slot)
            if arg_str in blocks: return blocks[arg_str]
            try: return ir.Constant(ir.DoubleType(), float(arg_str))
            except ValueError: return ir.Constant(ir.DoubleType(), 0.0)

        last_res_val = None
        
        # Pass 2: Compile instructions
        for instruction in mlir_data.operations:
            op = instruction.op
            args = instruction.args
            
            def get_arg(idx, default="0.0"):
                return args[idx] if len(args) > idx else default

            if op == "label":
                target_block = blocks[args[0]]
                if builder.block != target_block:
                    if not builder.block.is_terminated:
                        builder.branch(target_block)
                    builder.position_at_end(target_block)
                continue
            
            res = None

            if op == "br":
                if len(args) == 1:
                    builder.branch(resolve_arg(args[0]))
                elif len(args) == 3:
                    val = resolve_arg(args[0])
                    cond = val if val.type == ir.IntType(1) else builder.fcmp_ordered('>', val, ir.Constant(ir.DoubleType(), 0.5))
                    builder.cbranch(cond, resolve_arg(args[1]), resolve_arg(args[2]))
            elif op == "add":
                res = builder.fadd(resolve_arg(get_arg(0)), resolve_arg(get_arg(1)))
            elif op == "sub":
                res = builder.fsub(resolve_arg(get_arg(0)), resolve_arg(get_arg(1)))
            elif op == "mul":
                res = builder.fmul(resolve_arg(get_arg(0)), resolve_arg(get_arg(1)))
            elif op == "div":
                res = builder.fdiv(resolve_arg(get_arg(0)), resolve_arg(get_arg(1)))
            elif op == "cmp_eq":
                cmp = builder.fcmp_ordered('==', resolve_arg(get_arg(0)), resolve_arg(get_arg(1)))
                res = builder.uitofp(cmp, ir.DoubleType())
            elif op == "select":
                v0 = resolve_arg(get_arg(0))
                cond_i1 = v0 if v0.type == ir.IntType(1) else builder.fcmp_ordered('>', v0, ir.Constant(ir.DoubleType(), 0.5))
                res = builder.select(cond_i1, resolve_arg(get_arg(1)), resolve_arg(get_arg(2)))
            elif op == "load":
                ptr = resolve_arg(get_arg(0))
                if not isinstance(ptr.type, ir.PointerType):
                    res = ptr
                else:
                    if hasattr(ptr.type, 'pointee') and isinstance(ptr.type.pointee, ir.ArrayType):
                        ptr = builder.gep(ptr, [ir.Constant(ir.IntType(32), 0), ir.Constant(ir.IntType(32), 0)])
                    res = builder.load(ptr)
            elif op == "store":
                val = resolve_arg(get_arg(0))
                dest_name = get_arg(1)
                if dest_name in variables:
                    ptr = variables[dest_name]
                    # If it's a pointer slot (not array), we store into the pointer itself
                    if not isinstance(ptr.type.pointee, ir.ArrayType) and isinstance(ptr.type.pointee, ir.PointerType):
                        ptr = builder.load(ptr)
                    
                    if hasattr(ptr.type, 'pointee') and isinstance(ptr.type.pointee, ir.ArrayType) and not isinstance(val.type, ir.ArrayType):
                        ptr = builder.gep(ptr, [ir.Constant(ir.IntType(32), 0), ir.Constant(ir.IntType(32), 0)])
                    
                    if val.type != ptr.type.pointee:
                        if isinstance(ptr.type.pointee, ir.DoubleType): val = builder.sitofp(val, ir.DoubleType())
                        elif isinstance(ptr.type.pointee, ir.IntType): val = builder.fptosi(val, ptr.type.pointee)
                    builder.store(val, ptr)
            elif op == "gep":
                base = resolve_arg(get_arg(0))
                if isinstance(base.type, ir.PointerType):
                    indices = []
                    for i in range(1, len(args)):
                        idx_val = resolve_arg(args[i])
                        if idx_val.type == ir.DoubleType(): idx_val = builder.fptosi(idx_val, ir.IntType(32))
                        indices.append(idx_val)
                    if hasattr(base.type, 'pointee') and isinstance(base.type.pointee, ir.ArrayType) and len(indices) == 1:
                        indices = [ir.Constant(ir.IntType(32), 0)] + indices
                    res = builder.gep(base, indices)
            elif op == "icmp":
                raw_op = get_arg(0)
                cmp_op = OP_MAP.get(raw_op, '==')
                lhs, rhs = resolve_arg(get_arg(1)), resolve_arg(get_arg(2))
                if isinstance(lhs.type, ir.IntType):
                    if rhs.type != lhs.type:
                        if rhs.type == ir.DoubleType(): rhs = builder.fptosi(rhs, lhs.type)
                    cmp = builder.icmp_unsigned(cmp_op, lhs, rhs)
                else:
                    if rhs.type != lhs.type:
                        if rhs.type != ir.DoubleType(): rhs = builder.sitofp(rhs, ir.DoubleType())
                    cmp = builder.fcmp_ordered(cmp_op, lhs, rhs)
                res = builder.uitofp(cmp, ir.DoubleType())
            elif op == "alloc_struct":
                size = int(float(get_arg(1, "8")))
                res = builder.alloca(ir.ArrayType(ir.IntType(8), size))
            elif op == "string_view_ptr":
                base = resolve_arg(get_arg(0))
                offset = resolve_arg(get_arg(1))
                if offset.type == ir.DoubleType(): offset = builder.fptosi(offset, ir.IntType(32))
                if isinstance(base.type, ir.PointerType):
                    res = builder.gep(base, [offset])
            elif op == "strcmp" and strcmp_f:
                p1, p2_raw = resolve_arg(get_arg(0)), get_arg(1)
                if p2_raw not in variables and not p2_raw.replace('.','').isdigit():
                    s_val = bytes(p2_raw, "utf8") + b"\0"
                    s_type = ir.ArrayType(ir.IntType(8), len(s_val))
                    global_s = ir.GlobalVariable(module, s_type, name=f"str_{abs(hash(p2_raw))}")
                    global_s.initializer = ir.Constant(s_type, bytearray(s_val))
                    global_s.linkage = 'internal'
                    p2 = builder.gep(global_s, [ir.Constant(ir.IntType(32), 0), ir.Constant(ir.IntType(32), 0)])
                else: p2 = resolve_arg(p2_raw)
                if isinstance(p1.type, ir.PointerType):
                    res = builder.call(strcmp_f, [p1, p2])

            if instruction.target_var:
                if instruction.target_var not in variables:
                    with builder.goto_block(blocks["entry"]):
                        temp_builder = ir.IRBuilder(blocks["entry"])
                        if blocks["entry"].instructions: temp_builder.position_before(blocks["entry"].instructions[0])
                        # Default all slots to double unless specified
                        var_type = res.type if res else ir.DoubleType()
                        variables[instruction.target_var] = temp_builder.alloca(var_type, name=f"{instruction.target_var}_slot")
                
                if res:
                    builder.store(res, variables[instruction.target_var])
                    last_res_val = res
            
        if not builder.block.is_terminated:
            if instruction.target_var and instruction.target_var in variables:
                val = builder.load(variables[instruction.target_var])
                if not isinstance(val.type, ir.DoubleType):
                    val = builder.sitofp(val, ir.DoubleType())
                builder.ret(val)
            else:
                builder.ret(ir.Constant(ir.DoubleType(), 0.0))
        
        llmod = llvm.parse_assembly(str(module))
        
        # --- Optimization Pass ---
        pm = llvm.ModulePassManager()
        pm.add_sroa_pass()
        pm.add_instruction_combining_pass()
        pm.add_reassociate_expressions_pass()
        pm.add_gvn_pass()
        pm.add_cfg_simplification_pass()
        pm.run(llmod)

        engine = llvm.create_mcjit_compiler(llvm.parse_assembly(""), target_machine)
        engine.add_module(llmod)
        engine.finalize_object()
        func_ptr = engine.get_function_address(func_name)
        
        _KEEP_ALIVE.append((engine, llmod, target_machine))
        return ctypes_signature(func_ptr)
