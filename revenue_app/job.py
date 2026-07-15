import time
import uuid
import requests
import sys
import os


from revenue_app.database import SessionLocal, engine
from revenue_app import models



def calculate_status_revenues(orders_list):
    revenues = {"PROCESSED": 0.0, "PENDING": 0.0, "CANCELLED": 0.0}
    for order in orders_list:
        status = order.get("status")
        if status in revenues:
            revenues[status] += order.get("cart", {}).get("total_value", 0.0)
    return revenues

def run_job(run_count=None):
    # Make sure DB tables exist
    models.Base.metadata.create_all(bind=engine)
    
    print("Starting background job to fetch orders...")
    count = 0
    while True:
        if run_count is not None and count >= run_count:
            print(f"Reached run-count of {run_count}. Exiting loop.")
            break
        count += 1
        try:
            print("Fetching orders from /api/v1/orders...")
            response = requests.get("http://127.0.0.1:8080/api/v1/orders")
            if response.status_code == 200:
                raw_bytes = response.content
                orders_list = response.json()
                
                # Compute vip revenue inline
                import json
                data = json.loads(raw_bytes.decode('utf-8'))
                vip_rev = 0.0
                for order in data:
                    if order["user"]["is_vip"] and order["status"] == "PROCESSED":
                        vip_rev += order["cart"]["total_value"]
                
                # Compute status revenues
                status_revs = calculate_status_revenues(orders_list)
                
                # Write to DB
                db = SessionLocal()
                try:
                    new_record = models.RevenueDetails(
                        id=str(uuid.uuid4()),
                        vip_revenue=vip_rev,
                        processed_revenue=status_revs["PROCESSED"],
                        pending_revenue=status_revs["PENDING"],
                        cancelled_revenue=status_revs["CANCELLED"]
                    )
                    db.add(new_record)
                    db.commit()
                    print(f"Inserted revenue details: id={new_record.id}")
                except Exception as e:
                    print(f"Database error: {e}")
                    db.rollback()
                finally:
                    db.close()
            else:
                print(f"Failed to fetch orders, status code: {response.status_code}")
        except Exception as e:
            print(f"Job encountered an error: {e}")
            
        time.sleep(30)

if __name__ == "__main__":
    import sys
    if "--benchmark" in sys.argv:
        # Generate a dummy payload of 10,000 orders
        import json
        import timeit
        print("Generating dummy payload for benchmark...")
        payload = []
        for i in range(10000):
            payload.append({
                "id": str(uuid.uuid4()),
                "user": {"id": 1, "is_vip": (i % 5 == 0)},
                "cart": {"total_value": 150.0},
                "status": "PROCESSED" if i % 2 == 0 else "PENDING"
            })
        raw_bytes = json.dumps(payload).encode('utf-8')
        
        def run_bench(payload_bytes):
            # Mimic the pure computational block inside run_job
            data = json.loads(payload_bytes.decode('utf-8'))
            vip_rev = 0.0
            for order in data:
                if order["user"]["is_vip"] and order["status"] == "PROCESSED":
                    vip_rev += order["cart"]["total_value"]
            return vip_rev

        print("Warming up...")
        for _ in range(10): run_bench(raw_bytes)
        
        print("Benchmarking...")
        iters = 50
        total_time = timeit.timeit(lambda: run_bench(raw_bytes), number=iters)
        avg_time = (total_time / iters) * 1000
        res = run_bench(raw_bytes)
        
        print(f"  - Avg Speed: {avg_time:.4f} ms")
        print(f"  - Final Result[0,0]: {res:.4f}")
    else:
        run_count = None
        for arg in sys.argv[1:]:
            if arg.isdigit():
                run_count = int(arg)
                break
        run_job(run_count)
