import asyncio
import json
import websockets
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

async def handler(websocket):
    client_address = websocket.remote_address
    logger.info(f"Client connected from {client_address}")
    
    try:
        # Wait for the frontend to be fully ready
        await asyncio.sleep(2)
        
        # 1. Send MermaidViewer
        logger.info("Sending MermaidViewer intent")
        await websocket.send(json.dumps({
            "type": "MOUNT_COMPONENT",
            "component_name": "MermaidViewer",
            "payload": {
                "raw_syntax": """graph TD
    A[Start] --> B{Is it working?}
    B -- Yes --> C[Great!]
    B -- No --> D[Keep coding]"""
            }
        }))
        
        await asyncio.sleep(8)
        
        # 2. Send DiffEditor
        logger.info("Sending DiffEditor intent")
        await websocket.send(json.dumps({
            "type": "MOUNT_COMPONENT",
            "component_name": "DiffEditor",
            "session_id": "session_123",
            "payload": {
                "file_path": "search.py",
                "original": """def search(query):
    return results""",
                "proposed": """def search(query):
    results = get_results(query)
    return sorted(results, key=lambda x: x.cost)"""
            }
        }))
        
        # Keep connection alive and process incoming messages
        async for message in websocket:
            try:
                data = json.loads(message)
                logger.info(f"Received from client: {data}")
                if data.get("type") == "RESOLVE_INTENT":
                    logger.info(f"User decision for {data.get('session_id')}: {data.get('decision')}")
            except json.JSONDecodeError:
                logger.error(f"Received invalid JSON: {message}")

    except websockets.exceptions.ConnectionClosed as e:
        logger.info(f"Connection closed: {e}")
    except Exception as e:
        logger.error(f"Unexpected error: {e}")

async def main():
    async with websockets.serve(handler, "127.0.0.1", 8765):
        logger.info("Mock Backend running on ws://127.0.0.1:8765")
        await asyncio.Future()  # run forever

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        logger.info("Backend stopped by user")
