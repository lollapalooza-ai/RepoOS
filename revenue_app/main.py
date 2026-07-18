from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from typing import List
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))
from revenue_app import models
from revenue_app.database import engine, get_db

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.get("/api/v2/revenue")
def get_revenue(db: Session = Depends(get_db)):
    results = db.query(models.RevenueDetails).filter(models.RevenueDetails.cancelled_revenue > 20).all()
    return results

if __name__ == "__main__":
    import sys
    run_count = next((int(arg) for arg in sys.argv if arg.isdigit()), None)
    
    if run_count is not None:
        import time
        import revenue_app.main  # Force import of the module namespace so the Hijacker intercepts it!
        import revenue_app.database
        
        # Get a DB session
        db_gen = revenue_app.database.get_db()
        db = next(db_gen)
        
        # Warmup
        revenue_app.main.get_revenue(db)
        
        start = time.perf_counter()
        for _ in range(run_count):
            revenue_app.main.get_revenue(db)
        duration = time.perf_counter() - start
        
        print(f"  - Final Result[0,0]: {duration}")
        print(f"  - Avg Speed: {duration * 1000 / run_count:.4f} ms")
    else:
        import uvicorn
        uvicorn.run(app, host="127.0.0.1", port=8000)
