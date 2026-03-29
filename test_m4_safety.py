import asyncio
from component2_smt import verify_llm_safety, VerifiedMLIR, MemoryAllocation, Operation

def test_milestone4_safety():
    print("--- [TEST] Milestone 4: Verifier Expansion (Safety) ---")
    
    # 1. TEST: Valid GEP
    mlir_valid = VerifiedMLIR(
        thinking_process="Accessing element 1 of buffer.",
        memory_allocations=[MemoryAllocation(name="buf", size=8)],
        loop_limit=0,
        operations=[
            Operation(op="gep", args=["buf", "1"], target_var="ptr"),
            Operation(op="load", args=["ptr"], target_var="val")
        ]
    )
    is_safe, msg = verify_llm_safety(mlir_valid)
    print(f"Valid GEP: {is_safe}, Msg: {msg}")
    assert is_safe
    
    # 2. TEST: Invalid GEP (Out of bounds)
    mlir_invalid = VerifiedMLIR(
        thinking_process="Accessing element 99 of buffer.",
        memory_allocations=[MemoryAllocation(name="buf", size=8)],
        loop_limit=0,
        operations=[
            Operation(op="gep", args=["buf", "99"], target_var="ptr")
        ]
    )
    is_safe, msg = verify_llm_safety(mlir_invalid)
    print(f"Invalid GEP: {is_safe}, Msg: {msg}")
    assert not is_safe
    
    # 3. TEST: string_view_ptr bounds check
    mlir_sv_valid = VerifiedMLIR(
        thinking_process="Creating string view [0:4] in 8-byte buffer.",
        memory_allocations=[MemoryAllocation(name="buf", size=8)],
        loop_limit=0,
        operations=[
            Operation(op="string_view_ptr", args=["buf", "0", "4"], target_var="sv")
        ]
    )
    is_safe, msg = verify_llm_safety(mlir_sv_valid)
    print(f"Valid string_view_ptr: {is_safe}, Msg: {msg}")
    assert is_safe

    mlir_sv_invalid = VerifiedMLIR(
        thinking_process="Creating string view [5:5] in 8-byte buffer (5+5=10 > 8).",
        memory_allocations=[MemoryAllocation(name="buf", size=8)],
        loop_limit=0,
        operations=[
            Operation(op="string_view_ptr", args=["buf", "5", "5"], target_var="sv")
        ]
    )
    is_safe, msg = verify_llm_safety(mlir_sv_invalid)
    print(f"Invalid string_view_ptr: {is_safe}, Msg: {msg}")
    assert not is_safe

    print("✅ Milestone 4 Safety Verification Correct.")

if __name__ == "__main__":
    test_milestone4_safety()
