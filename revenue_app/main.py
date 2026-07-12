from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from typing import List

from . import models
from .database import engine, get_db

models.Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.get("/api/v2/revenue")
def get_revenue(db: Session = Depends(get_db)):
    results = db.query(models.RevenueDetails).filter(models.RevenueDetails.cancelled_revenue > 20).all()
    return results
