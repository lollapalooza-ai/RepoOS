# Milestone 1: Efficieny Improvements

## Engineering Directive: Repo OS Intent Manager Architecture Upgrade

**To:** Senior Software Engineer
**From:** Principal AI Architect
**Subject:** Transitioning to Deterministic, Low-Latency AI Orchestration

We are upgrading the core execution loops of Repo OS. Currently, our AI pipelines rely on brute-force file generation and regex-based heuristics. To scale this on local M4 hardware, we must transition the LLM from a "text generator" into a **deterministic control plane**. Please execute the following four architectural upgrades in order.

### Step 1: Replace Regex Infrastructure Detection with AST Queries (`ingest2.py`)

**The Context:** Currently, we use regex patterns like `requests\.(?P<method>get|post|put|delete)` to map infrastructure dependencies. This is highly brittle and will fail if a user aliases an import (e.g., `import requests as req`).

**The Action:** Migrate the `analyze_infra_usage` pipeline to use pure `tree-sitter` queries.

1. Write specific Tree-sitter S-expression queries to capture assignments and function calls simultaneously.
2. Traverse the AST to trace variable scope. If `req` is assigned to the `requests` module, your S-expression should inherently catch `req.get()`.
3. Update `create_api_call_relationship` to ingest the compiler-accurate nodes rather than regex capture groups.

### Step 2: Implement Constrained Decoding (Structured Outputs)

**The Context:** We are currently wasting precious compute cycles routing malformed LLM outputs through the heuristic `_repair_llm_json_string` function.

**The Action:**
Eliminate `_repair_llm_json_string` entirely. We will enforce strict JSON schema compliance at the inference level using Pydantic and Ollama's native constrained decoding capabilities.

1. Define a strict Pydantic model for the expected LLM output (e.g., a `RefactorProposal` schema).
2. When calling the local Qwen model, pass `format=RefactorProposal.model_json_schema()`. This intercepts the model's token logits, physically preventing it from sampling any token that violates the JSON structure.
3. Remove the heavy retry loop in `generate_with_retries`; the model will now guarantee parseable JSON on the first pass, drastically reducing latency.

### Step 3: Shift from Full-File Rewrites to Unified Diffing (`refactor2.py`)

**The Context:** The system prompt currently instructs the LLM that "values are the NEW, complete source code for that file". Forcing a 14B parameter model to hold a massive context window and regenerate thousands of unmodified lines destroys our Time To First Token (TTFT) and increases hallucination risks. Modern AI coding assistants (like Claude Code) rely on rapid, chunk-based diff algorithms.

**The Action:**

1. Update the `TIPTAP_SYSTEM_PROMPT` to output a `SearchAndReplace` schema instead of complete files.
2. The schema should enforce an array of objects containing an `exact_search_string` block and a `proposed_replace_string` block.
3. Implement a programmatic patcher in Python that searches the local file for the exact `search` block and applies the `replace` block.

### Step 4: Asynchronous WebSocket Orchestration (`server.py`)

**The Context:** The `refactor2.py` script relies on a synchronous `input()` call that blocks the main execution thread while waiting for user approval.

**The Action:**

1. Wire the existing FastAPI server in `server.py` to handle bidirectional WebSockets using `asyncio`.
2. Wrap the Qwen model inference inside an async generator. Instead of waiting for the full Tiptap JSON blueprint to generate, yield the tokens asynchronously.
3. Stream these tokens directly over the WebSocket to the React frontend.
4. Replace the CLI `input()` prompt with an `asyncio.Event()`. When the LLM finishes streaming the visual diff, suspend the backend execution. Resume and apply the disk patch only when the React UI sends a `RESOLVE_INTENT` payload back through the WebSocket.

# Milestone 2: Reliability Improvements

## Engineering Directive: Resilient Patching & State Sync Orchestration

**To:** Senior Software Engineer
**From:** Principal AI Architect
**Subject:** Implementation of Fault-Tolerant Patching, Triage, and IDE State Sync

Currently, our `apply_updates` function in `refactor2.py` blindly overwrites local files, which is a dangerous anti-pattern. To mature Repo OS into a true "Intent Manager", we must implement a defensive patching pipeline. Please execute the following architectural upgrades.

### 1. Implement the Hybrid "Smart Patcher" & Fault-Tolerant Cascade

We need to move away from brute-force string replacement and leverage our existing `tree_sitter_python` parser  as the semantic source of truth.

* **Step A: AST Anchor Targeting:** Update the LLM schema to output a `target_node_signature` (e.g., the function/class name) alongside the `SearchAndReplace` block. When the payload arrives, use `PY_LANGUAGE.query`  to extract the exact byte range of that node in the local file.


* **Step B: The `ERROR` Node Bypass:** When parsing the LLM's proposed replacement snippet, if `tree-sitter` generates an `ERROR` node *inside* the function body (due to Qwen generating cutting-edge/unsupported syntax), **catch but ignore the exception**. As long as the structural anchor nodes (function signature, indentation) match the AST, force the byte-range swap.
* **Step C: Chunk-Level Patience Diff (Fallback):** If the AST tree completely collapses, do not run a diff on the whole file. Isolate the target chunk using the line numbers from the Neo4j graph context. Apply a text-based Patience Diff strictly within that bounded chunk.



### 2. Implement the "Progressive Triage" Architecture (Hopeless Files)

We cannot feed broken files into the main `qwen2.5-coder:14b` refactor loop; it will hallucinate and burn through our `MAX_RETRIES`.

* 
**Step A: The Native Gatekeeper:** Before executing `get_hybrid_context`, run a blazing-fast native compiler check (e.g., `ast.parse(file_content)`). If it throws a `SyntaxError`, abort the main pipeline instantly.


* 
**Step B: Spawn the "Syntax Medic":** If the file is broken, route the isolated broken chunk to a specialized, low-temperature prompt. Instruct the LLM strictly to "Restore structural validity. Do not alter business logic."


* **Step C: The "Syntax Fracture" UI Escalation:** If the Medic fails after one attempt, emit a WebSocket payload `{"type": "MOUNT_COMPONENT", "component_name": "SyntaxFracture"}`. Mount a React component (similar to our `DiffEditor` ) that pauses the backend `asyncio.Event`  and asks the user to manually fix the missing bracket before proceeding.



### 3. Build the "Three-Layer Synchronization Mesh" (IDE Undo Handling)

We must prevent Repo OS from corrupting files if the user hits `Cmd+Z` in their IDE while the LLM is calculating the blueprint.

* 
**Step A: Pre-Flight Checksums:** Inside `fetch_file_content`, calculate an MD5/SHA-256 hash of the file payload. Pass this hash through the entire pipeline. Milliseconds before `apply_updates` executes the disk write, recalculate the disk file's hash. If they do not match, throw a `STATE_MUTATION_DETECTED` exception and abort.


* **Step B: IDE Event Bridge:** Build a minimal VS Code extension/MCP that listens to `onDidChangeTextDocument`. Plumb this into the existing FastAPI WebSocket server. If a text mutation event fires for a file currently locked in an active `RefactorSession`, send an interrupt signal to kill the Ollama inference thread to save compute. * **Step C: Strict Draft Mode:** Never write to the physical file directly. Always pipe the proposed changes to the `DiffEditor` via the `MOUNT_COMPONENT` event. Only execute the physical disk write when the React frontend sends back the `RESOLVE_INTENT` payload with `decision: "y"` .


# Milestone3: Repo OS Agentic Refactor & Ingestion Pipeline Upgrade

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Upgrading Repo OS from Scripted Refactoring to an Agentic AST-Aware State Machine
**Context:** Our current 14B parameter local LLM setup is failing on system-wide refactors due to context saturation, brittle string-matching, and a lack of post-patch validation. We are transitioning our `ingest2.py` and `refactor2.py` pipelines into a modern, AST-aware GraphRAG system with a self-healing execution loop.

Please implement the following architectural upgrades in the respective modules.

---

## Phase 1: Knowledge Graph & Ingestion Overhaul (`ingest2.py`)

Our current graph lacks the relational depth required to safely move code or audit dependencies. We need to upgrade our Tree-sitter parsing and Neo4j schema to build a true representation of the codebase's impact radius.

**1. Map Global `IMPORTED_BY` Edges:**

* **Task:** Upgrade the Tree-sitter `ALIAS_QUERY` logic. When a file is parsed, do not just track local imports. Construct a global index of exports and map `IMPORTED_BY` relationships in Neo4j.
* **Why:** If the LLM moves a class (e.g., `UnicodeCSVWriter`), the Model Context Protocol (MCP) must immediately query the graph for all `IMPORTED_BY` nodes to update upstream consumers.

**2. Link Tests to Implementation (`TESTS` Edges):**

* **Task:** Write a Tree-sitter query/heuristic to identify test files (e.g., files matching `test_*.py` or within a `tests/` directory). Map these files to the functions/classes they test using a `TESTS` edge.
* **Why:** Prevents the LLM from hallucinating new tests by providing exact mappings of what test logic covers what implementation logic.

**3. Extract Docstrings as First-Class Properties:**

* **Task:** Isolate docstrings using Tree-sitter and store them as distinct properties on the Neo4j function/class nodes, separate from the raw execution code block.
* **Why:** Allows for documentation audits without ever exposing the model to the execution logic, mathematically eliminating the risk of accidental indentation or syntax regressions during docstring updates.

---

## Phase 2: Execution Engine & Pydantic Schemas (`refactor2.py`)

We are deprecating the legacy `SearchAndReplace` schema. The execution engine must act like an agentic compiler, utilizing constrained decoding and strict validation boundaries.

**1. Expand Action Schemas (Constrained Decoding):**

* **Task:** Overhaul the Pydantic models used for the LLM's structured output. Replace the monolithic `SearchAndReplace` with a Union of distinct operations: `CreateFile`, `DeleteFile`, `ModifyNode`, and `AddImport`.
* **Why:** `AddImport` should specifically target the top of the AST to safely inject dependencies (like `from typing import Any`) without requiring the LLM to regex-match the existing import block. `CreateFile` ensures we can actually move classes to new files rather than just deleting them from the old ones.

**2. Transition to Targeted AST Replacements:**

* **Task:** Deprecate `exact_search_string`. Force the LLM to output a `target_node_signature` (e.g., `def get_model(app_label, model_name):`). Use Tree-sitter to find this exact node in the file and replace the *entire* node with the LLM's `proposed_replace_string`.

**3. Implement the Self-Healing CoT Loop:**

* **Task:** Break the monolithic execution into a Plan -> Execute -> Verify loop.
* **Plan:** LLM outputs an array of discrete steps.
* **Execute:** Engine applies *one* patch to the in-memory state.
* **Verify:** Engine runs `is_valid_python` (AST compilation check) on the modified file *immediately*.
* **Self-Heal:** If `SyntaxError` occurs, catch the traceback, reject the patch, and send the error back to the LLM as a system message: `"Applying this patch resulted in a SyntaxError: [Traceback]. Please correct the indentation or syntax and retry."`



---

## Phase 3: Prompt Engineering & Context Management

To prevent the "Lost in the Middle" phenomenon and hallucinated scope creep, we must tightly control what the model "sees" using precision routing and strict XML framing.

**1. Precision Routing via Sub-Tree GraphRAG:**

* **Task:** Do not pass entire files to `context_str`. Query the Neo4j graph for the exact AST node targeted for refactoring, plus the docstrings of immediately adjacent nodes. Pass only this sub-tree.

**2. Strict XML Delimiters:**

* **Task:** Wrap all injected context in the prompt builder with strict XML tags. This acts as a hard boundary for the attention heads of Qwen/Claude/Gemini.
* **Implementation Example:**

```xml
<file_context path="{file_path}">
<node type="{node_type}" signature="{node_signature}">
{node_code}
</node>
<dependencies>
{adjacent_docstrings}
</dependencies>
</file_context>

<instruction>
{user_prompt}
Output MUST strictly conform to the Pydantic Action Union. DO NOT modify any code outside the provided node bounds.
</instruction>

```

# Milestone: 3.1 : Additional fixes - Execution Guardrails & Anti-Laziness Heuristics

# ENGINEERING BRIEF: Execution Guardrails & Repo-Agnostic Path Resolution

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Patching Destructive Overwrites, Token Laziness, and Path Truncation in Repo OS
**Context:** Our 14B execution engine (`refactor2.py`) is currently vulnerable to token laziness (outputting placeholders), destructive file overwrites, and LLM path truncation. We are moving to a hardened, repo-agnostic execution loop that treats the LLM as an untrusted input source.

Please implement the following four phases directly into `refactor2.py`.

---

### Phase 1: Repo-Agnostic Path Resolution (Virtual Filesystem Routing)

LLMs notoriously truncate paths, dropping the workspace root (e.g., outputting `core/csv_utils.py` instead of `django-oscar/src/oscar/core/csv_utils.py`). We must dynamically resolve these paths based on the `master_state` context map without hardcoding repository-specific strings like `oscar/`.

**Task:** Inject this standalone utility function into `refactor2.py` to handle path reconstruction via overlap detection.

```python
import os

def resolve_path(target_path: str, master_state: dict) -> str:
    """
    Repo-agnostic path resolution. Maps an LLM's potentially truncated 
    or relative path to the true workspace path.
    """
    known_paths = list(master_state.keys())
    if not known_paths:
        return target_path

    # 1. Exact Match (The LLM provided the perfect path)
    if target_path in known_paths:
        return target_path

    # 2. Suffix Match (Handles Modification of existing files)
    # If LLM outputs "core/csv_utils.py", we match it to "src/app/core/csv_utils.py"
    suffix_matches = [p for p in known_paths if p.endswith(target_path)]
    if len(suffix_matches) == 1:
        return suffix_matches[0]

    # 3. Path Reconstruction (Handles CreateFile)
    # Infer the working directory from the common path of all files currently in context
    try:
        common_dir = os.path.commonpath(known_paths)
    except ValueError:
        common_dir = "" # Fallback if paths are on different drives

    if common_dir and not target_path.startswith(common_dir):
        # Normalize separators for cross-platform compatibility
        target_parts = target_path.replace('\\', '/').split('/')
        common_parts = common_dir.replace('\\', '/').split('/')

        # Detect overlap to prevent directory duplication 
        # (e.g., common_dir="src/app", target="app/new.py" -> "src/app/new.py")
        overlap_idx = 0
        for i in range(1, min(len(common_parts), len(target_parts)) + 1):
            if common_parts[-i:] == target_parts[:i]:
                overlap_idx = i

        if overlap_idx > 0:
            return os.path.join(common_dir, *target_parts[overlap_idx:])
        else:
            return os.path.join(common_dir, target_path)

    return target_path

```

---

### Phase 2: State Machine Guardrails (Block Destructive Overwrites)

We must protect the `master_state` from being overwritten by an accidental `CreateFile` action.

**Task:** Modify the action processing loop in `apply_actions_to_state` to utilize the new `resolve_path` function and explicitly reject `CreateFile` on existing files.

```python
for action in actions:
    # 1. Resolve the path dynamically
    resolved_path = resolve_path(action.file_path, master_state)
    
    # 2. Block destructive overwrites
    if action.action == "create_file":
        if resolved_path in master_state:
            raise ValueError(
                f"Action Rejected: Cannot use 'create_file' on existing file '{resolved_path}'. "
                f"You MUST use 'modify_node' or 'add_import'."
            )
        new_state[resolved_path] = action.content
    
    # (Continue with other action handling...)

```

---

### Phase 3: Semantic Sanity Checks (Anti-Placeholder Validation)

A syntactically valid AST is useless if the semantics are destroyed by placeholders. We must upgrade the validation loop to mathematically reject token laziness.

**Task:** Upgrade your `is_valid_python` function. Inject a string-matching heuristic *before* the AST parse to catch common LLM placeholders.

```python
def is_valid_python(content: str) -> bool:
    # 1. Anti-Placeholder Guardrail
    forbidden_phrases = [
        "# placeholder", 
        "# ...", 
        "pass  #", 
        "# rest of code",
        "# existing code"
    ]
    
    content_lower = content.lower()
    for phrase in forbidden_phrases:
        if phrase in content_lower:
            raise ValueError(
                f"Code contains forbidden placeholder: '{phrase}'. "
                f"Token laziness is strictly prohibited. You MUST write the COMPLETE and executable node."
            )
    
    # 2. Syntax Check
    try:
        ast.parse(content)
        return True
    except SyntaxError as e:
        raise ValueError(f"SyntaxError during AST parse: {str(e)}")

```

*Note: Ensure your execution loop catches this `ValueError` and pipes the exception string back into the LLM's retry message array.*

---

### Phase 4: Aggressive System Prompting

Smaller models (14B) require aggressive, negative constraints in the system prompt to properly align their generation weights with our strict Pydantic schema.

**Task:** Rewrite the system prompt initialization to explicitly forbid the failure modes we observed in Suite 3.

```python
sys_prompt = (
    "You are an elite Principal AI Engineer refactoring a complex Python monolith. "
    "You will be provided with a strict sub-tree of the codebase. "
    "CRITICAL RULES: \n"
    "1. NEVER use the 'create_file' action to modify an existing file. It will wipe the file.\n"
    "2. NO TOKEN LAZINESS. You are strictly forbidden from using placeholders like '# ...' or '# existing code'. "
    "If you use a 'modify_node' action, you MUST output the entire, unbroken, executable code for that node.\n"
    "3. When creating new files, ensure you include ALL necessary imports."
)

```