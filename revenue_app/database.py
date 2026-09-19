from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker

import os
DATABASE_URL = os.environ.get("DATABASE_URL", "mysql+pymysql://revenue_user:revenue_password@127.0.0.1:3306/revenue_db")

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
