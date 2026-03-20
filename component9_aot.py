import os
import sys
import asyncio
import llvmlite.ir as ir
from component2_smt import verified_generation_loop
from neo4j import GraphDatabase

NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
CACHE_DIR = "./.poly_cache"

def generate_vectorized_llvm_ir() -> str:
    """
    Hardcoded v1.5 generator for Struct-of-Arrays.
    In v2.0, the LLM will generate this dynamically.
    """
    module = ir.Module(name="struct_transformer_kernel")
    bool_ptr = ir.PointerType(ir.IntType(8))
    double_ptr = ir.PointerType(ir.DoubleType())
    func_type = ir.FunctionType(ir.DoubleType(), [ir.IntType(32), bool_ptr, double_ptr])
    func = ir.Function(module, func_type, name="vectorized_vip_sum")
    
    block = func.append_basic_block(name="entry")
    builder = ir.IRBuilder(block)
    size, vip_ptr, val_ptr = func.args
    
    sum_ptr = builder.alloca(ir.DoubleType(), name="total_sum")
    builder.store(ir.Constant(ir.DoubleType(), 0.0), sum_ptr)
    idx_ptr = builder.alloca(ir.IntType(32), name="loop_idx")
    builder.store(ir.Constant(ir.IntType(32), 0), idx_ptr)
    
    loop_cond = builder.append_basic_block(name="loop_cond")
    loop_body = builder.append_basic_block(name="loop_body")
    loop_end = builder.append_basic_block(name="loop_end")
    builder.branch(loop_cond)
    
    builder.position_at_end(loop_cond)
    idx_val = builder.load(idx_ptr)
    cond = builder.icmp_signed('<', idx_val, size)
    builder.cbranch(cond, loop_body, loop_end)
    
    builder.position_at_end(loop_body)
    current_vip_ptr = builder.gep(vip_ptr, [idx_val])
    is_vip = builder.load(current_vip_ptr)
    is_vip_bool = builder.trunc(is_vip, ir.IntType(1))
    
    with builder.if_then(is_vip_bool):
        current_val_ptr = builder.gep(val_ptr, [idx_val])
        val = builder.load(current_val_ptr)
        curr_sum = builder.load(sum_ptr)
        builder.store(builder.fadd(curr_sum, val), sum_ptr)
        
    next_idx = builder.add(idx_val, ir.Constant(ir.IntType(32), 1))
    builder.store(next_idx, idx_ptr)
    builder.branch(loop_cond)
    
    builder.position_at_end(loop_end)
    builder.ret(builder.load(sum_ptr))
    
    return str(module)

async def aot_compile_all(target_module: str = "legacy_shop"):
    if not os.path.exists(CACHE_DIR):
        os.makedirs(CACHE_DIR)
        
    # 1. Compile the Array Macro-Benchmark (LLVM IR Cache)
    print("--- 🚀 AOT Compiling Vectorized Kernels ---")
    macro_cache_path = os.path.join(CACHE_DIR, "vectorized_vip_sum.ll")
    with open(macro_cache_path, 'w') as f:
        f.write(generate_vectorized_llvm_ir())
    print(f"✅ Cached Array Kernel to: {macro_cache_path}")
    
    # 2. Add the Neo4j dynamic fetching for standard functions
    print(f"\n--- 🚀 Scanning Neo4j for module: '{target_module}' ---")
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    with driver.session() as session:
        query = "MATCH (f:Function) WHERE f.arg_count IS NOT NULL RETURN f.name, f.code, f.arg_count"
        result = session.run(query)
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
            
        print(f"   🧠 Triggering LLM Generation & Z3 Verification...")
        intent = (
            f"You are an expert compiler frontend. Convert this exact Python logic into a DOD MLIR execution graph: \n"
            f"```python\n{func_code}\n```\n"
            f"The function takes {arg_count} float inputs. You MUST name them 'arg0' through 'arg{arg_count - 1}'.\n"
            f"Only use opcodes: 'add', 'sub', 'mul', 'div', 'cmp_eq', 'select'.\n"
            f"Store the final calculated result in the target_var of the last operation."
        )
        
        try:
            verified_mlir = await verified_generation_loop(intent)
            with open(cache_file, 'w', encoding='utf-8') as f:
                f.write(verified_mlir.model_dump_json(indent=2))
            print(f"   💾 SUCCESS: Saved verified MLIR to {cache_file}")
        except Exception as e:
            print(f"   ❌ FAILED to compile '{func_name}': {e}")

if __name__ == "__main__":
    target = sys.argv[1] if len(sys.argv) > 1 else "legacy_shop"
    asyncio.run(aot_compile_all(target))
