import asyncio
from google import genai
import os

# Vertex AI Configuration from component2_smt.py
PROJECT_ID = "911836544224"
LOCATION = "us-central1"

async def test_call():
    print("Testing Gemini Call...")
    try:
        client = genai.Client(
            vertexai=True,
            project=PROJECT_ID,
            location=LOCATION
        )
        response = await client.aio.models.generate_content(
            model='gemini-2.0-flash', 
            contents="Say 'Hello from RepoOS!'"
        )
        print(f"Response: {response.text}")
    except Exception as e:
        print(f"Failed: {e}")

if __name__ == "__main__":
    asyncio.run(test_call())
