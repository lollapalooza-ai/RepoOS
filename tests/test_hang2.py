import asyncio
from component2_smt import get_client

async def main():
    print("Call 1...")
    res = await get_client().aio.models.generate_content(
        model='gemini-2.5-flash',
        contents='Hello 1'
    )
    print("Success 1")
    print("Call 2...")
    res2 = await get_client().aio.models.generate_content(
        model='gemini-2.5-flash',
        contents='Hello 2'
    )
    print("Success 2")

if __name__ == "__main__":
    asyncio.run(main())
