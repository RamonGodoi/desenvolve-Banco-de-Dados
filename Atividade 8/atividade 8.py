from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from sqlalchemy import create_engine, text
import os

app = FastAPI()

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://user:password@localhost/PartnerService")
engine = create_engine(DATABASE_URL)

class Partner(BaseModel):
    id: str
    tradingName: str
    ownerName: str
    document: str
    address: dict
    coverageArea: dict

@app.post("/partners")
def create_partner(partner: Partner):
    query = text("""
        INSERT INTO Partners (id, tradingName, ownerName, document, address, coverageArea)
        VALUES (:id, :tradingName, :ownerName, :document, ST_GeomFromGeoJSON(:address), ST_GeomFromGeoJSON(:coverageArea))
    """)
    with engine.connect() as conn:
        conn.execute(query, **partner.dict())
    return {"message": "Partner created successfully"}

@app.get("/partners/{id}")
def get_partner(id: str):
    query = text("SELECT * FROM Partners WHERE id = :id")
    with engine.connect() as conn:
        result = conn.execute(query, {"id": id}).fetchone()
    if not result:
        raise HTTPException(status_code=404, detail="Partner not found")
    return dict(result)

@app.get("/partners/search")
def search_partner(lat: float, long: float):
    query = text("""
        SELECT *, ST_Distance(address, ST_SetSRID(ST_MakePoint(:long, :lat), 4326)) AS distance
        FROM Partners
        WHERE ST_Contains(coverageArea, ST_SetSRID(ST_MakePoint(:long, :lat), 4326))
        ORDER BY distance
        LIMIT 1
    """)
    with engine.connect() as conn:
        result = conn.execute(query, {"lat": lat, "long": long}).fetchone()
    if not result:
        raise HTTPException(status_code=404, detail="No partner covers this area")
    return dict(result)
