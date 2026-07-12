from sqlalchemy import Column, String, Float
from .database import Base

class RevenueDetails(Base):
    __tablename__ = "revenue_details"

    id = Column(String(36), primary_key=True, index=True)
    vip_revenue = Column(Float, default=0.0)
    processed_revenue = Column(Float, default=0.0)
    pending_revenue = Column(Float, default=0.0)
    cancelled_revenue = Column(Float, default=0.0)
