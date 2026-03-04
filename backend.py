import os
import sys
import json
import asyncio
import logging
from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
import refactor2

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("RepoOS-Backend")

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Store pending human approvals
pending_resolutions = {}

async def process_refactor(websocket: WebSocket, prompt: str):
    logger.info(f"🚀 Processing Refactor: {prompt}")
    
    # 1. Hybrid Context Gathering
    context_map = await asyncio.to_thread(refactor2.get_hybrid_context, prompt)
    if not context_map:
        await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": "No relevant code context found."}})
        return

    # Fetch initial file state and checksums (Step 3A: Pre-Flight Checksums)
    files_content = {}
    master_checksums = {}
    for path in context_map:
        content = refactor2.fetch_file_content(path)
        if content:
            files_content[path] = content
            master_checksums[path] = refactor2.calculate_checksum(content)

            # Step 2A: The Native Gatekeeper (Syntax Check)
            if not refactor2.is_valid_python(content):
                logger.warning(f"⚠️ Syntax Error in {path}. Escalating to SyntaxFracture UI.")
                session_id = f"syntax_fracture_{int(asyncio.get_event_loop().time())}"
                pending_resolutions[session_id] = {"event": asyncio.Event(), "decision": None}
                
                await websocket.send_json({
                    "type": "MOUNT_COMPONENT",
                    "component_name": "SyntaxFracture",
                    "session_id": session_id,
                    "payload": {
                        "file_path": path,
                        "content": content,
                        "error_type": "SyntaxError"
                    }
                })
                
                # Step 2C: Wait for user to manually fix the syntax
                await pending_resolutions[session_id]["event"].wait()
                # Decision 'y' means the user fixed it and wants to retry
                if pending_resolutions[session_id]["decision"] == 'y':
                    # Refresh content and checksum after fix
                    new_content = refactor2.fetch_file_content(path)
                    if new_content and refactor2.is_valid_python(new_content):
                        files_content[path] = new_content
                        master_checksums[path] = refactor2.calculate_checksum(new_content)
                    else:
                        await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": "File still has syntax errors. Aborting."}})
                        return
                else:
                    await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": "Refactor aborted by user during syntax triage."}})
                    return
                del pending_resolutions[session_id]
    
    # 2. Sequential Task Generation (Streaming)
    task_sys_prompt = "You are a senior architect. Generate a sequential list of refactoring tasks."
    task_user_prompt = f"INSTRUCTION: {prompt}\nCONTEXT: {json.dumps(context_map)}"
    
    full_task_json = ""
    async for token in refactor2.generate_streaming_json(task_sys_prompt, task_user_prompt, refactor2.TaskList):
        full_task_json += token
        await websocket.send_json({"type": "TASK_STREAM", "payload": {"token": token}})
    
    try:
        task_list = refactor2.TaskList.model_validate_json(full_task_json)
    except Exception as e:
        logger.error(f"Failed to parse TaskList: {e}")
        return

    # 3. Execute Tasks Sequentially
    master_state = files_content.copy()
    
    for i, task in enumerate(task_list.tasks):
        await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": f"Executing Task {i+1}: {task.task}"}})
        
        step_files = {p: master_state.get(p, "") for p in task.context if p in master_state}
        context_str = "\n\n".join(f"--- FILE: {p} ---\n{c}" for p, c in step_files.items())
        
        sys_prompt = "You are a Principal Engineer. Provide surgical SearchAndReplace patches."
        user_prompt = f"CONTEXT:\n{context_str}\n\nINSTRUCTION:\n{task.task}"
        
        full_patch_json = ""
        async for token in refactor2.generate_streaming_json(sys_prompt, user_prompt, refactor2.RefactorProposal):
            full_patch_json += token
            await websocket.send_json({"type": "PATCH_STREAM", "payload": {"token": token, "task_index": i}})

        try:
            proposal = refactor2.RefactorProposal.model_validate_json(full_patch_json)
            # Use original checksums to detect external modifications during the session
            new_state = refactor2.apply_patches_to_state(master_state, proposal.patches, master_checksums)
            
            # 4. Human-in-the-Loop Approval (Step 3C: Strict Draft Mode)
            session_id = f"task_{i}_{int(asyncio.get_event_loop().time())}"
            pending_resolutions[session_id] = {"event": asyncio.Event(), "decision": None}
            
            # Send diff for preview
            changed_path = None
            for path, new_content in new_state.items():
                if master_state.get(path) != new_content:
                    changed_path = path
                    await websocket.send_json({
                        "type": "MOUNT_COMPONENT",
                        "component_name": "DiffEditor",
                        "session_id": session_id,
                        "payload": {
                            "file_path": path,
                            "original": master_state.get(path, ""),
                            "proposed": new_content
                        }
                    })
                    break

            if not changed_path:
                logger.info(f"Task {i+1} resulted in no changes.")
                continue

            await pending_resolutions[session_id]["event"].wait()
            if pending_resolutions[session_id]["decision"] == 'y':
                master_state.update(new_state)
                await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": f"Task {i+1} applied in-memory."}})
            else:
                await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": "Refactor aborted by user."}})
                return
            
            del pending_resolutions[session_id]
            
        except Exception as e:
            logger.error(f"Error in task execution: {e}")
            return

    # 5. Final Disk Write (Strict Checksum Verification)
    await asyncio.to_thread(refactor2.apply_updates, master_state, master_checksums)
    await websocket.send_json({"type": "SYSTEM_NOTIFICATION", "payload": {"message": "All changes persisted to disk."}})

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            data = await websocket.receive_text()
            msg = json.loads(data)
            
            if msg["type"] == "USER_PROMPT":
                asyncio.create_task(process_refactor(websocket, msg["payload"]["text"]))
            
            elif msg["type"] == "RESOLVE_INTENT":
                sid = msg.get("session_id")
                if sid in pending_resolutions:
                    pending_resolutions[sid]["decision"] = msg.get("decision")
                    pending_resolutions[sid]["event"].set()

    except WebSocketDisconnect:
        logger.info("WebSocket disconnected")

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8765)
