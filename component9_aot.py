import os
import sys
import asyncio
import llvmlite.ir as ir
from component2_smt import verified_generation_loop
from neo4j import GraphDatabase

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
CACHE_DIR = "./.poly_cache"

def generate_symbolic_lexer_llvm_ir() -> str:
    """
    MILESTONE 2.5: FULL-PRECISION SYMBOLIC LEXER (STABLE)
    """
    module = ir.Module(name="zero_copy_precision_lexer")
    byte_ptr = ir.PointerType(ir.IntType(8))
    func_type = ir.FunctionType(ir.DoubleType(), [byte_ptr, ir.IntType(32)])
    func = ir.Function(module, func_type, name="vectorized_vip_sum")
    
    entry = func.append_basic_block(name="entry")
    builder = ir.IRBuilder(entry)
    buf, length = func.args
    
    idx_p = builder.alloca(ir.IntType(32), name="idx_p")
    builder.store(ir.Constant(ir.IntType(32), 0), idx_p)
    sum_p = builder.alloca(ir.DoubleType(), name="sum_p")
    builder.store(ir.Constant(ir.DoubleType(), 0.0), sum_p)
    vip_p = builder.alloca(ir.IntType(1), name="vip_p")
    builder.store(ir.Constant(ir.IntType(1), 0), vip_p)
    v_idx_p = builder.alloca(ir.IntType(32), name="v_idx_p")
    acc_p = builder.alloca(ir.DoubleType(), name="acc_p")
    dot_p = builder.alloca(ir.IntType(1), name="dot_p")
    div_p = builder.alloca(ir.DoubleType(), name="div_p")
    
    loop_cond = func.append_basic_block(name="loop_cond")
    loop_body = func.append_basic_block(name="loop_body")
    exit_blk = func.append_basic_block(name="exit")
    builder.branch(loop_cond)
    
    builder.position_at_end(loop_cond)
    idx = builder.load(idx_p)
    safe_len = builder.sub(length, ir.Constant(ir.IntType(32), 64))
    is_done = builder.icmp_signed('>=', idx, safe_len)
    builder.cbranch(is_done, exit_blk, loop_body)
    
    builder.position_at_end(loop_body)
    char = builder.load(builder.gep(buf, [idx]))
    is_quote = builder.icmp_unsigned('==', char, ir.Constant(ir.IntType(8), 34))
    
    with builder.if_then(is_quote):
        v_seq = [105, 115, 95, 118, 105, 112, 34, 58, 116] # is_vip":t
        v_m = ir.Constant(ir.IntType(1), 1)
        for i, code in enumerate(v_seq):
            p = builder.gep(buf, [builder.add(idx, ir.Constant(ir.IntType(32), i + 1))])
            v_m = builder.and_(v_m, builder.icmp_unsigned('==', builder.load(p), ir.Constant(ir.IntType(8), code)))
        with builder.if_then(v_m):
            builder.store(ir.Constant(ir.IntType(1), 1), vip_p)

        f_seq = [105, 115, 95, 118, 105, 112, 34, 58, 102] # is_vip":f
        f_m = ir.Constant(ir.IntType(1), 1)
        for i, code in enumerate(f_seq):
            p = builder.gep(buf, [builder.add(idx, ir.Constant(ir.IntType(32), i + 1))])
            f_m = builder.and_(f_m, builder.icmp_unsigned('==', builder.load(p), ir.Constant(ir.IntType(8), code)))
        with builder.if_then(f_m):
            builder.store(ir.Constant(ir.IntType(1), 0), vip_p)

        t_seq = [116, 111, 116, 97, 108, 95, 118, 97, 108, 117, 101, 34, 58]
        t_m = ir.Constant(ir.IntType(1), 1)
        for i, code in enumerate(t_seq):
            p = builder.gep(buf, [builder.add(idx, ir.Constant(ir.IntType(32), i + 1))])
            t_m = builder.and_(t_m, builder.icmp_unsigned('==', builder.load(p), ir.Constant(ir.IntType(8), code)))
            
        with builder.if_then(t_m):
            builder.store(builder.add(idx, ir.Constant(ir.IntType(32), 14)), v_idx_p)
            builder.store(ir.Constant(ir.DoubleType(), 0.0), acc_p)
            builder.store(ir.Constant(ir.IntType(1), 0), dot_p)
            builder.store(ir.Constant(ir.DoubleType(), 0.1), div_p)
            
            p_cond = func.append_basic_block(name="p_cond")
            p_body = func.append_basic_block(name="p_body")
            p_end = func.append_basic_block(name="p_end")
            builder.branch(p_cond)
            
            builder.position_at_end(p_cond)
            cur_v_idx = builder.load(v_idx_p)
            cur_v_char = builder.load(builder.gep(buf, [cur_v_idx]))
            is_digit = builder.and_(builder.icmp_unsigned('>=', cur_v_char, ir.Constant(ir.IntType(8), 48)),
                                    builder.icmp_unsigned('<=', cur_v_char, ir.Constant(ir.IntType(8), 57)))
            is_dot = builder.icmp_unsigned('==', cur_v_char, ir.Constant(ir.IntType(8), 46))
            builder.cbranch(builder.or_(is_digit, is_dot), p_body, p_end)
            
            builder.position_at_end(p_body)
            with builder.if_else(is_dot) as (then, otherwise):
                with then: builder.store(ir.Constant(ir.IntType(1), 1), dot_p)
                with otherwise:
                    digit_val = builder.uitofp(builder.sub(cur_v_char, ir.Constant(ir.IntType(8), 48)), ir.DoubleType())
                    with builder.if_else(builder.load(dot_p)) as (t2, o2):
                        with t2:
                            m = builder.load(div_p)
                            builder.store(builder.fadd(builder.load(acc_p), builder.fmul(digit_val, m)), acc_p)
                            builder.store(builder.fmul(m, ir.Constant(ir.DoubleType(), 0.1)), div_p)
                        with o2:
                            builder.store(builder.fadd(builder.fmul(builder.load(acc_p), ir.Constant(ir.DoubleType(), 10.0)), digit_val), acc_p)
            builder.store(builder.add(cur_v_idx, ir.Constant(ir.IntType(32), 1)), v_idx_p)
            builder.branch(p_cond)
            
            builder.position_at_end(p_end)
            with builder.if_then(builder.load(vip_p)):
                builder.store(builder.fadd(builder.load(sum_p), builder.load(acc_p)), sum_p)
            builder.store(builder.load(v_idx_p), idx_p)
            builder.branch(loop_cond)

    new_idx = builder.add(builder.load(idx_p), ir.Constant(ir.IntType(32), 1))
    builder.store(new_idx, idx_p)
    builder.branch(loop_cond)
    
    builder.position_at_end(exit_blk)
    builder.ret(builder.load(sum_p))
    return str(module)

async def aot_compile_all(target_module: str = "legacy_shop"):
    if not os.path.exists(CACHE_DIR): os.makedirs(CACHE_DIR)
    
    print("--- 🚀 AOT Compiling FULL-FIDELITY SYMBOLIC LEXER (STABLE) ---")
    with open(os.path.join(CACHE_DIR, "vectorized_vip_sum.ll"), 'w') as f:
        f.write(generate_symbolic_lexer_llvm_ir())
    print(f"✅ Cached Precision Parser.")

    print(f"\n--- 🚀 Scanning Neo4j for module: '{target_module}' ---")
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    with driver.session() as session:
        query = "MATCH (f:Function) WHERE f.arg_count IS NOT NULL"
        if target_module != "all":
            query += " AND f.file CONTAINS $path"
        query += " RETURN f.name, f.code, f.arg_count"
        
        result = session.run(query, path=target_module)
        records = [r for r in result]
        
    for record in records:
        func_name = record["f.name"]
        func_code = record["f.code"]
        arg_count = record["f.arg_count"]
        
        print(f"\n[AOT] Targeting: {func_name} (Args: {arg_count})")
        cache_file = os.path.join(CACHE_DIR, f"{func_name}.json")
        
        if os.path.exists(cache_file):
            print(f"   ⚡ Cache hit! '{func_name}' is already compiled. Skipping.")
            continue
            
        # [FIX] Define arg_desc for non-FSM functions
        arg_desc = f"takes {arg_count} float inputs: named 'arg0' through 'arg{arg_count - 1}'" if arg_count > 0 else "takes 0 inputs"

        # MILESTONE 3.0.1: Cognitive Forcing Prompt
        # [REFACTORED] Use different prompts for FSM vs Scalar Math
        if func_name == "vectorized_vip_sum":
            intent = (
                f"You are an expert LLVM FSM Generator. You are receiving a raw TCP JSON payload.\n"
                f"TASK: Generate a Zero-Copy Finite State Machine.\n"
                f"CRITICAL: You must use the 'thinking_process' field FIRST. In this field, explicitly write out the exact ASCII byte sequence you are searching for. Calculate the exact byte offsets you need to jump before extracting the float.\n"
                f"After your thinking process, write the operations using `gep`, `load`, `icmp`, and `br`."
            )
        else:
            intent = f"""
You are an expert compiler frontend. Convert this Python logic into a DOD MLIR JSON execution graph.
You MUST use the `thinking_process` field first to trace the variables before writing the operations.

EXAMPLE:
Python: 
def calc(arg0, arg1): return arg0 * 0.2 if arg1 > 10 else arg0

Expected JSON Structure:
{{
  "thinking_process": "1. The function takes two args. 2. I need to multiply arg0 by 0.2 and store in t1. 3. I need to compare arg1 > 10 and store in cond. 4. I need to select t1 or arg0 based on cond.",
  "memory_allocations": [],
  "loop_limit": 0,
  "operations": [
    {{"op": "mul", "args": ["arg0", "0.2"], "target_var": "t1"}},
    {{"op": "icmp", "args": [">", "arg1", "10"], "target_var": "cond"}},
    {{"op": "select", "args": ["cond", "t1", "arg0"], "target_var": "final_result"}}
  ]
}}

Now, compile this target:
```python
{func_code}
```
The function {arg_desc}.
Only use allowed opcodes. Store the final calculated result in the target_var of the last operation.
"""
        
        try:
            # MILESTONE 3.0: Pass func_code and arg_count down the pipeline
            verified_mlir = await verified_generation_loop(intent, func_code, arg_count)
            with open(cache_file, 'w', encoding='utf-8') as f:
                f.write(verified_mlir.model_dump_json(indent=2))
            print(f"   💾 SUCCESS: Saved verified MLIR to {cache_file}")
        except Exception as e:
            print(f"   ❌ FAILED to compile '{func_name}': {e}")

if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else "legacy_shop"
    asyncio.run(aot_compile_all(target))
