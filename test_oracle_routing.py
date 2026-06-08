import asyncio
from component2_smt import compile_function_logic

async def test_oracle():
    tracks = ["MATH", "FSM", "TABULAR", "BRANCHING", "CRYPTO"]
    code = "def sample(): pass"
    
    for track in tracks:
        print(f"\n--- Testing Track: {track} ---")
        result = await compile_function_logic(code, track)
        print(f"Result Type: {type(result)}")
        if hasattr(result, 'text'):
            print(f"Result Text: {result.text[:100]}...")
        else:
            print(f"Result: {result}")

if __name__ == "__main__":
    asyncio.run(test_oracle())
