For repo os, we want to build an application for macbooks. It will have one prompt window - that also takes commands. There will be a layout for displaying response from the AI models - may it be formatted text, generated cityscape & subway images, code diffs, code file editors etc. It may look something as simple as this one but support all of the features listed above. The tool must be very lightweight so we give enough room for the AI model to run locally. 

The goal is - 1. user says "generate a cityscape of checkout process", the intent manager generates the mermaid/cityscape image. 2. User says "edit search API to sort by cost", the LLM proposes the changes and user types "y/n/edit" (already supported by refactor2.py). 3. User says "open the search.py file for editing" the view should bring up the file editor. So on and so forth. 


Here is the comprehensive, end-to-end system design for the Repo OS Intent Manager. This document is written for a Senior Software Engineer to immediately begin implementation.

We are transitioning from a synchronous, CLI-bound script (`refactor2.py`) to an **Asynchronous, Event-Driven Architecture**. The core philosophy here is that the LLM is no longer just a text generator; it is the **Control Plane** that emits structured commands to drive a dynamic UI.

---

### Phase 1: The API Contract (The Intent Protocol)

Before writing any logic, we must define the strict JSON schema that the frontend and backend will use to communicate over WebSockets (or Tauri IPC). This is the lifeblood of the Intent Manager.

**1. The Client-to-Server Payload (User Action):**

```json
{
  "message_id": "uuid-1234",
  "type": "USER_PROMPT",
  "payload": {
    "text": "Edit search API to sort by cost",
    "context_files": ["src/api/search.py"] 
  }
}

```

**2. The Server-to-Client Payload (LLM Intent/System Event):**
The backend LLM will use Function Calling/Structured Output to generate intents. The Python server validates these and forwards them to the frontend.

```json
{
  "message_id": "uuid-1234",
  "type": "MOUNT_COMPONENT",
  "component_name": "DiffEditor", 
  "status": "AWAITING_USER_ACTION",
  "payload": {
    "file_path": "src/api/search.py",
    "original_content": "...",
    "proposed_content": "..."
  }
}

```

**Supported `component_name` values:** `ChatStream`, `MermaidViewer`, `Cityscape3D`, `DiffEditor`, `MonacoEditor`.

---

### Phase 2: Backend Architecture (Python + FastAPI)

The biggest engineering hurdle is converting `refactor2.py` from a blocking script to an asynchronous service.

**Step 2.1: Implement an Async WebSocket Server**
Use FastAPI with WebSockets to maintain a persistent, bidirectional connection with the frontend.

**Step 2.2: Refactoring `refactor2.py` (The Async State Machine)**
Currently, `refactor2.py` uses `input("Apply changes? (y/n)")`. This blocks the main thread. The Senior Engineer must rewrite this using `asyncio.Event` and a session manager.

```python
# Pseudo-code for the new async refactor engine
class RefactorSession:
    def __init__(self, session_id):
        self.session_id = session_id
        self.user_approval_event = asyncio.Event()
        self.user_decision = None # 'y', 'n', or 'edit'

    async def wait_for_user(self):
        await self.user_approval_event.wait()
        return self.user_decision

# Inside your WebSocket handler:
async def process_refactor_intent(ws, prompt, file_path):
    # 1. LLM generates the diff
    diff_payload = await llm_generate_diff(prompt, file_path)
    
    # 2. Emit the diff to the frontend to mount the Monaco Diff View
    await ws.send_json({
        "type": "MOUNT_COMPONENT",
        "component_name": "DiffEditor",
        "payload": diff_payload
    })
    
    # 3. Suspend backend execution until the user clicks 'Approve' or 'Reject' in the UI
    session = session_manager.create_session()
    decision = await session.wait_for_user() 
    
    # 4. Resume execution based on UI event
    if decision == 'y':
        apply_changes_to_disk(diff_payload)
        await ws.send_json({"type": "SYSTEM_NOTIFICATION", "message": "Changes applied."})

```

**Step 2.3: The LLM Intent Router**
Wrap the local Qwen model inference in an Intent Router. When a user prompt arrives, inject a system prompt forcing the LLM to output JSON matching our Intent Protocol, rather than conversational text.

---

### Phase 3: Frontend Architecture (React/WebView)

The frontend acts as a **Dynamic Orchestrator**. It should *not* have hardcoded layouts. Instead, it listens to the WebSocket and mounts components on the fly.

**Step 3.1: The Component Registry**
Create a registry pattern mapping intent strings to actual React components.

```javascript
const ComponentRegistry = {
  ChatStream: React.lazy(() => import('./components/ChatStream')),
  MermaidViewer: React.lazy(() => import('./components/MermaidViewer')),
  DiffEditor: React.lazy(() => import('./components/DiffEditor')),
  MonacoEditor: React.lazy(() => import('./components/MonacoEditor')),
};

```

**Step 3.2: The Main Canvas Reducer**
Use a React `useReducer` or Zustand store to manage the state of the Multi-Modal Canvas based on incoming WebSocket events.

```javascript
// When the backend sends {"type": "MOUNT_COMPONENT", "component_name": "DiffEditor"}
function canvasReducer(state, action) {
  switch (action.type) {
    case 'MOUNT_COMPONENT':
      return {
        ...state,
        activeComponent: action.component_name,
        componentProps: action.payload,
        isAwaitingUser: action.status === 'AWAITING_USER_ACTION'
      };
    // ...
  }
}

```

**Step 3.3: Handling User Resolution (y/n/edit)**
Inside the `DiffEditor` component, build the "Approve" and "Reject" buttons. When clicked, these send a WebSocket message *back* to the Python server to resolve the `asyncio.Event` we paused in Step 2.2.

```javascript
const handleApprove = () => {
    webSocket.send(JSON.stringify({
        type: "RESOLVE_INTENT",
        session_id: currentSession,
        decision: "y"
    }));
};

```

---

### Phase 4: Step-by-Step Execution Flows

To ensure the Senior Engineer understands the lifecycle, here is how the three specific use cases flow through this architecture:

**Flow 1: "Generate a cityscape of checkout process"**

1. **FE:** Sends `USER_PROMPT` to Backend.
2. **BE:** LLM processes intent -> queries Neo4j for "checkout" architecture.
3. **BE:** LLM generates Mermaid syntax.
4. **BE:** Sends `MOUNT_COMPONENT` (`MermaidViewer` or `Cityscape3D`) with the raw syntax in the payload.
5. **FE:** Canvas unmounts the chat, mounts `MermaidViewer`, passes the syntax to the Web Worker for rendering.

**Flow 2: "Edit search API to sort by cost"**

1. **FE:** Sends `USER_PROMPT` to Backend.
2. **BE:** LLM analyzes `search.py` and creates a visual diff.
3. **BE:** Sends `MOUNT_COMPONENT` (`DiffEditor`) and **halts execution** awaiting user response.
4. **FE:** Canvas mounts Monaco Diff Editor. User reviews code. User clicks "Approve".
5. **FE:** Sends `RESOLVE_INTENT` (`decision: "y"`) to Backend.
6. **BE:** Async event unlocks. Python writes changes to `search.py`.

**Flow 3: "Open search.py for editing"**

1. **FE:** Sends `USER_PROMPT` to Backend.
2. **BE:** Intent Router identifies "Read File" intent. Bypasses heavy LLM inference.
3. **BE:** Python reads `search.py` from disk.
4. **BE:** Sends `MOUNT_COMPONENT` (`MonacoEditor`) with file text.
5. **FE:** Canvas mounts the standard code editor.

### Principal Engineer's Final Directive

Tell the Senior Engineer to **build the WebSocket communication and the React Component Registry first**, using mock JSON payloads. Do not attach the LLM until the frontend can successfully mount a Diff Viewer, a Mermaid Viewer, and an Editor purely based on receiving a dummy JSON event. Once the UI orchestration is proven, wire up the local Qwen model and the async `refactor2.py` engine.