import os
import time
import psutil
import httpx
from fastapi import FastAPI
import uvicorn

app = FastAPI()

@app.get("/api/v2/records")
async def get_records():
    process = psutil.Process(os.getpid())
    
    # Record start metrics
    start_time = time.perf_counter()
    start_cpu_time = time.process_time()
    
    # Call the revenue_app endpoint (assuming it runs on port 8000)
    async with httpx.AsyncClient() as client:
        response = await client.get("http://127.0.0.1:8000/api/v2/revenue")
        data = response.json()
        
    # Record end metrics
    end_time = time.perf_counter()
    end_cpu_time = time.process_time()
    
    # Calculate metrics
    processing_time_ms = (end_time - start_time) * 1000
    cpu_time_ms = (end_cpu_time - start_cpu_time) * 1000
    memory_mb = process.memory_info().rss / (1024 * 1024)
    
    # Print metrics just before returning
    print("\n" + "="*40)
    print("📊 /api/v2/records - Request Metrics")
    print("="*40)
    print(f"⏱️  Processing Time : {processing_time_ms:.2f} ms")
    print(f"💻 CPU Time        : {cpu_time_ms:.2f} ms")
    print(f"🧠 Memory Usage    : {memory_mb:.2f} MB")
    print("="*40 + "\n")
    
    return data

if __name__ == "__main__":
    print("Starting Records API Server on port 8001...")
    uvicorn.run(app, host="127.0.0.1", port=8001)
