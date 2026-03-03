import os
import sys
import json
import asyncio
import logging
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
from api_cityscape import router as cityscape_router

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("RepoOS-Backend")

# Attempt to import refactor2 for real logic integration
try:
    import refactor2
    REFACTOR_READY = True
    logger.info("✅ refactor2.py bridge established.")
except ImportError as e:
    logger.error(f"❌ Could not import refactor2.py: {e}.")
    REFACTOR_READY = False

app = FastAPI()
app.include_router(cityscape_router)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

pending_resolutions = {}

async def route_intent(websocket: WebSocket, prompt: str):
    if not REFACTOR_READY:
        await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": "Refactor engine not available."}})
        return

    logger.info(f"Processing prompt: {prompt}")
    p_lower = prompt.lower()
    
    # 1. Gather hybrid context (Neo4j + Embeddings) with Graceful Fallback
    context_map = {}
    try:
        # We run this in a thread because refactor2's neo4j calls are blocking
        context_map, context_error = await asyncio.to_thread(refactor2.get_hybrid_context, prompt)
        if context_error:
            logger.warning(f"Context error: {context_error}")
    except Exception as e:
        logger.warning(f"Neo4j context gathering failed: {e}. Falling back to keyword search.")
        # Fallback: simple keyword search in prompt for file paths
        for word in prompt.split():
            # Basic heuristic for file paths
            clean_word = word.strip('.,!"\'')
            if "." in clean_word and (os.path.exists(clean_word) or "/" in clean_word):
                context_map[clean_word] = []
        
        await websocket.send_json({
            "type": "SYSTEM_NOTIFICATION", 
            "payload": {"message": "Neo4j connection failed. Using local file fallback."}
        })

    # Flow 1: Generate Architecture/Blueprint (Cityscape or Mermaid)
    if "cityscape" in p_lower:
        logger.info("Flow 1: Generating Semantic Cityscape View")
        from api_cityscape import get_semantic_cityscape
        cityscape_data = await get_semantic_cityscape()
        await websocket.send_json(cityscape_data)

    elif any(k in p_lower for k in ["mermaid", "architecture", "graph", "flow"]):
        logger.info("Flow 1: Generating Living Specification")
        
        # Use refactor2 to generate the architectural blueprint
        _, blueprint = await asyncio.to_thread(
            refactor2.draft_and_review_living_blueprint,
            "auto", prompt, context_map or {}, True
        )
        
        mermaid_syntax = ""
        if blueprint and 'content' in blueprint:
            for block in blueprint['content']:
                if block.get('type') == 'codeBlock' and block.get('attrs', {}).get('language') == 'mermaid':
                    content_list = block.get('content', [])
                    if content_list:
                        mermaid_syntax = content_list[0].get('text', '')
                        break
        
        if not mermaid_syntax:
            mermaid_syntax = "graph TD\n  A[Error] --> B[LLM failed to generate Mermaid syntax in blueprint]"

        await websocket.send_json({
            "type": "MOUNT_COMPONENT",
            "component_name": "MermaidViewer",
            "payload": {"raw_syntax": mermaid_syntax}
        })

    # Flow 2: Code Refactoring (Diff Editor)
    elif any(k in p_lower for k in ["edit", "refactor", "sort", "change", "update"]):
        logger.info("Flow 2: Generating Code Refactor")
        
        if not context_map:
            # If fallback also failed, we can't refactor safely
            await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": "No code context found. Please mention the file path in your prompt."}})
            return

        # Fetch current content of files in context
        files_content = {}
        for path in context_map:
            content = refactor2.fetch_file_content(path)
            if content:
                files_content[path] = content
        
        if not files_content:
            await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": f"Could not find files: {list(context_map.keys())}"}})
            return

        system_prompt = "You are a Principal Engineer. Your response MUST be a JSON object where keys are filenames and values are the NEW, complete source code for that file."
        context_str = "\n\n".join(f"--- FILE: {path} ---\n{content}" for path, content in files_content.items())
        user_prompt = f"CONTEXT:\n{context_str}\n\nINSTRUCTION:\n{prompt}"
        
        # Call refactor2's self-healing generation logic (in thread)
        proposed_changes = await asyncio.to_thread(
            refactor2.generate_with_retries,
            system_prompt, user_prompt, files_content, refactor2.AGENT_PROVIDER
        )
        
        if not proposed_changes:
            await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": "LLM failed to generate a valid refactor plan."}})
            return

        session_id = f"refactor_{int(asyncio.get_event_loop().time())}"
        pending_resolutions[session_id] = {"event": asyncio.Event(), "decision": None}
        
        first_file = list(proposed_changes.keys())[0]
        
        await websocket.send_json({
            "type": "MOUNT_COMPONENT",
            "component_name": "DiffEditor",
            "session_id": session_id,
            "payload": {
                "file_path": first_file,
                "original": files_content.get(first_file, ""),
                "proposed": proposed_changes[first_file]
            }
        })
        
        await pending_resolutions[session_id]["event"].wait()
        decision = pending_resolutions[session_id]["decision"]
        
        if decision == 'y':
            await asyncio.to_thread(refactor2.apply_updates, proposed_changes)
            await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": f"Successfully applied changes."}})
        else:
            await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": "Refactoring discarded."}})
        
        del pending_resolutions[session_id]

    # Flow 3: Open/View File (Monaco Editor)
    elif any(k in p_lower for k in ["open", "read", "view", "show"]):
        logger.info("Flow 3: Opening File")
        file_to_open = list(context_map.keys())[0] if context_map else None
        
        if not file_to_open:
            await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": "Please specify a valid file path."}})
            return

        content = refactor2.fetch_file_content(file_to_open)
        if content:
            await websocket.send_json({
                "type": "MOUNT_COMPONENT",
                "component_name": "MonacoEditor",
                "payload": {
                    "file_path": file_to_open,
                    "content": content,
                    "language": "python" if file_to_open.endswith('.py') else "plaintext"
                }
            })
        else:
            await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": f"File not found: {file_to_open}"}})
    
    else:
        await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": f"Instruction processed. No UI component mapped for this request type."}})

@app.websocket("/ws")
@app.websocket("/")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    logger.info("WebSocket connected")
    try:
        while True:
            data = await websocket.receive_text()
            message = json.loads(data)
            
            if message["type"] == "USER_PROMPT":
                prompt = message["payload"]["text"]
                asyncio.create_task(route_intent(websocket, prompt))
            
            elif message["type"] == "RESOLVE_INTENT":
                sid = message.get("session_id")
                decision = message.get("decision")
                if sid in pending_resolutions:
                    pending_resolutions[sid]["decision"] = decision
                    pending_resolutions[sid]["event"].set()

    except WebSocketDisconnect:
        logger.info("WebSocket disconnected")

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8765)
