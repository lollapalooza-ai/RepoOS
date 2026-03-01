# Repo OS - "Cityscape" 3D Rendering Engine Implementation

**Role:** Senior Full-Stack 3D & React Developer
**Project:** Repo OS - "MRI for Your Codebase"
**Context:** Repo OS is a local-first AI interface. We use a Python/FastAPI backend with a Neo4j Graph Database. The frontend is React. The user prompts an onboard LLM (like Qwen), which uses an "Intent Protocol" to command the UI to mount specific views.
**Task:** Implement the End-to-End "Cityscape" codebase visualization. Files are represented as 3D "buildings", and directories are "districts/neighborhoods".
**CRITICAL CONSTRAINTS:** 1. The app runs locally on Unified Memory hardware (e.g., Apple M-Series 24GB). The local LLM and the 3D WebGL context share the *same* RAM and compute.
2. You MUST prioritize memory management, compute offloading, and render-loop throttling.
3. **DO NOT modify `mapper.py`.** You must create a new backend pipeline specifically for this macroscopic view.

Please implement this feature strictly adhering to the following 4 phases and file structures:

---

### PHASE 1: Backend Data Pipeline

**File to Create:** `api_cityscape.py`
**Goal:** Extract the global repository graph and format it for the frontend layout engine.

1. **The Cypher Query:** Write a Neo4j query that fetches all structural nodes (Files/Classes) and their dependencies (`DEPENDS_ON` edges).
* *Metrics Needed:* `id` (filepath), `loc` (Lines of Code), `complexity` (Cognitive/Cyclomatic score), and `module_path` (Directory structure).


2. **FastAPI Endpoint:** Create a `GET /api/v1/views/cityscape` endpoint.
* Do *not* calculate 3D coordinates on the backend.
* Group the nodes into `districts` based on their `module_path`.
* Output a strict JSON schema:
```json
{
  "intent": "MOUNT_COMPONENT",
  "component": "Cityscape3D",
  "data": {
    "districts": ["auth", "database", "ui"],
    "nodes": [
      { "id": "auth/login.py", "district": "auth", "loc": 250, "complexity": 15, "dependencies": ["database/db.py"] }
    ]
  }
}

```





---

### PHASE 2: Compute Offloading (Web Workers)

**File to Create:** `frontend2/src/workers/cityscapeLayoutWorker.js`
**Goal:** Prevent the React main thread from freezing when calculating the spatial layout of thousands of nodes.

1. **Worker Setup:** Listen for the `message` event containing the JSON payload from Phase 1.
2. **Layout Algorithm:** * First, calculate bounding boxes for each "district" based on the number of nodes inside it.
* Second, apply a grid-packing or bounded force-directed algorithm to assign `x` and `z` coordinates to every building *within* its district's bounds.
* Map `loc` to a `height` value (Y-axis scale).
* Map `complexity` to a hex `color` (Low = `#2ecc71`, High = `#e74c3c`).


3. **Return Payload:** Post an optimized flat array of coordinates, dimensions, and colors back to the main thread, ready for Three.js matrix insertion.

---

### PHASE 3: Frontend Orchestration & Memory Governor

**File to Create:** `frontend2/src/components/views/CityscapeView.tsx`
**Goal:** Ensure the 3D engine does not crash the local LLM or exhaust Unified Memory.

1. **Lazy Loading:** Wrap the 3D canvas rendering child component using `React.lazy()`.
2. **Demand-Driven Rendering (The Pause Pattern):** * Subscribe to the global state `isLLMGenerating`.
* Pass a `pauseRender` boolean prop down to the Three.js canvas. The WebGL loop MUST stop requesting animation frames while the LLM is streaming tokens.


3. **2D Overlay for Tooltips:** Implement a floating `<div>` overlay for tooltips. When the 3D canvas emits a hover event, update the React state to position the `<div>` at the `(x,y)` screen coordinates. Do *not* render text meshes inside WebGL.

---

### PHASE 4: The 3D Rendering Engine

**File to Create:** `frontend2/src/three/CityscapeRenderer.ts`
**Goal:** Build a 60 FPS interactive 3D scene capable of rendering 10,000+ files using Three.js via the Canvas API.

1. **Instancing (ABSOLUTE REQUIREMENT):** You MUST use `THREE.InstancedMesh` for the buildings.
* Do *not* create a separate `Mesh` for every file.
* Apply the calculated X/Z coordinates and Y-scale via `setMatrixAt()`.
* Apply the complexity color via `setColorAt()`.


2. **Visual Elements:**
* *Ground:* Render dark, flat `PlaneGeometry` underneath the buildings for each district.
* *Connections:* Use `THREE.LineSegments` or `THREE.InstancedBufferGeometry` for the dependency lines. Keep them semi-transparent (`opacity: 0.1`) until hovered.


3. **Raycasting & Interaction:**
* Implement a `THREE.Raycaster` on `pointermove`.
* On intersect, emit an event containing the `instanceId` and screen coordinates to the React wrapper to trigger the tooltip.
* On click, dispatch an event to global state: `{ action: "PROMPT_CONTEXT", target: file_id }`.


4. **Ruthless Garbage Collection:** Implement a `destroy()` method called by the React `useEffect` cleanup.
* Call `.dispose()` on EVERY `BufferGeometry` and `Material`.
* Call `renderer.dispose()` and `renderer.forceContextLoss()`.
* Remove all window/canvas event listeners.



---

Important: 
1. Before you build the React components, verify the `cityscapeLayoutWorker.js` math. If the layout logic is flawed, the buildings will overlap, and the 3D view will be useless.
2. When you provide `CityscapeRenderer.ts`, explicitly check for the `destroy()` method. If `.dispose()` is missing on geometries or materials, reject the code. Memory leaks in an electron/tauri app running an LLM are fatal.