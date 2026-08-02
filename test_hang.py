import asyncio
from component2_smt import get_client

async def main():
    print("Testing aio client...")
    try:
        res = await get_client().aio.models.generate_content(
            model='gemini-2.5-flash',
            contents='Hello'
        )
        print("Success:", res.text)
    except Exception as e:
        print("Error:", e)

if __name__ == "__main__":
    asyncio.run(main())
