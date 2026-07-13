import time
import uuid
import requests
import sys
import os


from revenue_app.database import SessionLocal, engine
from revenue_app import models

def calculate_vip_revenue(orders: bytes) -> float:
    """
    Sum the total cart values, but ONLY for VIP users.
    Accepts raw JSON bytes directly from the network buffer.
    """
    import json
    data = json.loads(orders.decode('utf-8'))
    total_revenue = 0.0
    for order in data:
        if order["user"]["is_vip"] and order["status"] == "PROCESSED":
            total_revenue += order["cart"]["total_value"]
            
    return total_revenue

def calculate_status_revenues(orders_list):
    revenues = {"PROCESSED": 0.0, "PENDING": 0.0, "CANCELLED": 0.0}
    for order in orders_list:
        status = order.get("status")
        if status in revenues:
            revenues[status] += order.get("cart", {}).get("total_value", 0.0)
    return revenues

def run_job():
    # Make sure DB tables exist
    models.Base.metadata.create_all(bind=engine)
    
    print("Starting background job to fetch orders...")
    while True:
        try:
            print("Fetching orders from /api/v1/orders...")
            response = requests.get("http://127.0.0.1:8080/api/v1/orders")
            if response.status_code == 200:
                raw_bytes = response.content
                orders_list = response.json()
                
                # Compute vip revenue
                vip_rev = calculate_vip_revenue(raw_bytes)
                
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
    run_job()
