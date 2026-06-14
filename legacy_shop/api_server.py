# legacy_shop/api_server.py
from fastapi import FastAPI
from .ecommerce import generate_payload
import uvicorn

app = FastAPI()

# Generate the massive payload once when the server boots
print("Generating 500k E-Commerce Payload in memory...")
MASSIVE_PAYLOAD = generate_payload(500)

@app.get("/api/v1/orders")
def get_orders():
    """
    Simulates a heavy database query returning a massive JSON list.
    """
    return MASSIVE_PAYLOAD

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8080)
