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

# Milestone 3.2 : Reliability and Safety 3.2

### 1. The Cross-File Dependency Conundrum

Tools like `pyflakes` (and even modern single-file linters like `ruff`) analyze Abstract Syntax Trees one file at a time. If the LLM renames `UnicodeCSVWriter` to `CSVUtil` in `compat.py`, and updates `reports.py` to say `from oscar.core.compat import CSVUtil`, `pyflakes` looking at `reports.py` will pass it as 100% perfectly valid! It only checks if the local namespace is satisfied; it does not trace the import edge to see if `CSVUtil` actually exists in the target file.

**The Solution: The "Virtual Workspace" Type-Check**
To catch cross-file dependency breaks before the user ever sees them, we cannot just lint strings in memory. We must implement a "Virtual Workspace Validation" step at the very end of the execution loop:

1. The LLM finishes its Plan-Execute-Validate loop (using `pyflakes` or `ruff` for fast, single-file syntax/NameError checks).
2. Before declaring success, `refactor2.py` dumps the proposed `new_state` dictionary into a temporary directory (`tempfile.TemporaryDirectory`).
3. The engine runs a fast multi-file type checker like `mypy` or `pyright` across that isolated temp directory.
4. If `mypy` flags `error: Module "oscar.core.compat" has no attribute "CSVUtil"`, we catch it, abort the transaction, and feed that exact cross-file error back to the LLM for a final self-correction.

---

### 2. Engineering Brief: Implementing Macro-Actions & Semantic Validation

Here is the exact, step-by-step system prompt to hand to your Senior Engineer to resolve the Suite 3.1 failures.

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Upgrading Repo OS with Macro-Actions, Dynamic Scoping, and Semantic Validation
**Context:** Our 14B model has proven its baseline loop works (Test 8), but it is failing on multi-step orchestration (moving nodes) and context starvation (hardcoded K=5 vector limits). We must upgrade the engine to use Macro-Actions and Semantic Validation to abstract complexity away from the LLM.

Please implement the following five phases directly into `refactor2.py` and `ingest2.py`.

---

#### Phase 1: Dynamic Context Scoping (Fixing the K=5 Blindspot)

**The Problem:** In Test 9, the LLM only audited a fraction of a 1700-line file because `ingest2.py` hardcodes the vector search to `LIMIT 5`.
**Task:** Update `get_hybrid_context()` to support Intent-Based Scoping.

* **Implementation:** Before querying the vector DB, check the user's prompt for file-level intents (e.g., "audit the file", "all functions in"). If detected, bypass the vector similarity search. Instead, execute a Neo4j Cypher query to pull the *entire* AST skeleton for that specific file:
```cypher
MATCH (f:File {path: $target_path})-[:CONTAINS]->(node)
RETURN node.name, node.signature, node.docstring

```



#### Phase 2: Safe Directory Resolution (Corrected Code)

The previous snippet relied on `os.path.isdir()`, which will fail if the virtual paths do not exist on the local disk at the time of execution. The safer, purely path-based heuristic is to check if the calculated `common_path` exactly matches one of our known file paths. If it does, we know it's a file, and we must extract its directory.

Please replace the `try...except` block in `resolve_path` with this robust string-based implementation:

```python
    # 3. Path Reconstruction (Handles CreateFile)
    # Infer the working directory from the common path of all files currently in context
    try:
        common_path = os.path.commonpath(known_paths)
        # Fix: Ensure we extract the directory if the common path is actually a file
        # This prevents NotADirectoryError when master_state only has one file
        if common_path in known_paths:
            common_dir = os.path.dirname(common_path)
        else:
            common_dir = common_path
    except ValueError:
        common_dir = "" # Fallback if paths are on different drives

```


#### Phase 3: Agentic Macro-Actions (`MoveNode`)

**The Problem:** 14B models fail to coordinate `ModifyNode` (delete) + `CreateFile` + `AddImport` in a single pass.
**Task:** Add a `MoveNode` primitive to the Pydantic Union.

* **Implementation:** ```python
class MoveNode(BaseModel):
action: Literal["move_node"] = "move_node"
source_file: str
target_file: str
node_signature: str
```
In `apply_actions_to_state`, write the Python logic to handle the orchestration: find the node in `source_file`, pop it out, append it to `target_file`, and inject the necessary imports. The LLM only has to output the `MoveNode` JSON, and Python does the heavy lifting.


```



#### Phase 4: Linter-in-the-Loop (Semantic Validation)

**The Problem:** Tests 2, 4, and 7 failed due to `NameError` (missing imports like `Any` or `settings`). `ast.parse` does not catch undefined names.
**Task:** Upgrade the `is_valid_python` function to run a fast `pyflakes` or `ruff` pass in memory.

* **Implementation:**
```python
import pyflakes.api
import pyflakes.reporter
import io

def is_semantically_valid(content: str) -> tuple[bool, str]:
    # 1. Syntax Check
    try:
        ast.parse(content)
    except SyntaxError as e:
        return False, f"SyntaxError: {str(e)}"

    # 2. Semantic Check (Catches missing imports / undefined names)
    output = io.StringIO()
    reporter = pyflakes.reporter.Reporter(output, output)
    pyflakes.api.check(content, '', reporter)

    errors = output.getvalue()
    if "undefined name" in errors:
        return False, f"Missing Import detected: {errors.strip()}. You MUST use 'add_import'."

    return True, ""

```


Wire the output of this function into the LLM's retry loop.

#### Phase 5: Forbidding Phantom Deletions

**The Problem:** The LLM is using `DeleteFile` to wipe files it doesn't understand.
**Task:** Enforce strict semantic constraints on the `DeleteFile` action.

* **Implementation:** In the system prompt, add: *"CRITICAL RULE: NEVER use the `delete_file` action unless the user's prompt explicitly contains the words 'delete' or 'remove' for that specific file. To remove code from a file, use `modify_node`."*


#### Phase6. Resolving AST Namespace Collisions in Macro-Actions

This is a phenomenal edge case to consider. When building macro-actions like `MoveNode`, you cannot blindly append code to a new file, or you risk silent namespace shadowing (where the newly moved `UnicodeCSVWriter` overwrites the third-party import, breaking existing functions in `csv_utils.py` that relied on the external library).

To handle this deterministically, we do not let the LLM guess. We implement a **Pre-flight Namespace Check** in the Python execution engine.

Here is how we architect the collision resolution:

#### The Strategy: Deterministic Rejection via `ASTCollisionError`

Instead of writing complex logic to automatically alias imports (which requires rewriting all subsequent function calls in the file), we treat a namespace collision as a fatal validation error. We use the `ast` module to scan the target file's namespace *before* applying the move, and feed the collision back to the LLM to solve.

**Step 1: The Pre-flight Checker**
Inside your `MoveNode` execution logic, before you append the node to the `target_file`, parse the target file to collect all defined names and imported names.

```python
import ast

def get_namespace_identifiers(file_content: str) -> set:
    """Extracts all function names, class names, and imported aliases from a file's AST."""
    identifiers = set()
    try:
        tree = ast.parse(file_content)
        for node in ast.walk(tree):
            if isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
                identifiers.add(node.name)
            elif isinstance(node, ast.Import):
                for alias in node.names:
                    identifiers.add(alias.asname or alias.name)
            elif isinstance(node, ast.ImportFrom):
                for alias in node.names:
                    identifiers.add(alias.asname or alias.name)
    except SyntaxError:
        pass # Handle syntax errors separately in the main loop
    return identifiers

```

**Step 2: Enforce the Collision Guardrail**
When the `MoveNode` action is evaluated, extract the name of the node being moved (e.g., `UnicodeCSVWriter` from the `node_signature`) and check it against the target file's namespace.

```python
class ASTCollisionError(Exception):
    pass

# Inside apply_actions_to_state for MoveNode:
target_content = master_state.get(action.target_file, "")
if target_content:
    target_namespace = get_namespace_identifiers(target_content)
    moved_node_name = extract_name_from_signature(action.node_signature) # e.g., 'UnicodeCSVWriter'
    
    if moved_node_name in target_namespace:
        raise ASTCollisionError(
            f"Namespace Collision: Cannot move '{moved_node_name}' to '{action.target_file}'. "
            f"The target file already contains a class, function, or import with the exact same name. "
            f"Please use 'modify_node' to alias the existing import in the target file before moving."
        )

```

**Step 3: The Self-Healing Loop**
When `ASTCollisionError` is raised, your retry loop catches it and pipes it back to the LLM.

Because we feed the exact collision reason back to the agent, the LLM will naturally self-correct by first issuing a `ModifyNode` to change the target file's import to `from third_party import UnicodeCSVWriter as ExternalCSVWriter`, and *then* issuing the `MoveNode` command. This delegates the semantic reasoning back to the LLM while Python enforces the strict structural safety of the AST.

# Milestone 3.3 : Conflicting Rules Removal
# ENGINEERING BRIEF: Resolving Deadlocks, Differential Linting, and Best-Effort Execution

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Upgrading Repo OS Execution Engine (`refactor2.py`) - Suite 3.2 Fixes
**Context:** Our 14B model is hitting a Negative Prompting Fallacy. By telling it "Do not use delete_file", we inadvertently trapped its attention mechanism, causing deadlocks. Furthermore, our global `mypy` validation is too strict, rejecting valid AST patches due to pre-existing legacy type errors. We are implementing Dynamic Schema Pruning, Differential Static Analysis, and Best-Effort Execution to finalize the stability of the execution loop.

Please implement the following four phases sequentially into `refactor2.py`.

---

### Phase 1: Dynamic Schema Pruning (Solving the `delete_file` Deadlock)

**The Problem:** The LLM gets trapped trying to use `delete_file` because it exists in the JSON schema grammar, even if the system prompt forbids it. When the Python engine rejects it, it retries the same forbidden action until it aborts.
**The Fix:** Dynamically prune the JSON schema injected into the LLM context based on the user's intent.

**Step 1:** Define two separate Pydantic Unions. Remove `DeleteFile` from the safe default.

```python
from pydantic import BaseModel, Field
from typing import List, Union, Literal

# --- Define Base Actions ---
# (Assuming CreateFile, ModifyNode, AddImport, MoveNode are already defined)

# --- Define the dynamic Unions ---
class RefactorProposalSafe(BaseModel):
    """Schema used for standard refactoring. DeleteFile is mathematically impossible."""
    actions: List[Union[CreateFile, ModifyNode, AddImport, MoveNode]]

class RefactorProposalUnsafe(BaseModel):
    """Schema used ONLY when the user explicitly requests a deletion."""
    actions: List[Union[CreateFile, DeleteFile, ModifyNode, AddImport, MoveNode]]

```

**Step 2:** Dynamically select the schema before calling the LLM generation function.

```python
# Inside your main orchestration loop, before generating the JSON:
user_intent_lower = user_prompt.lower()
requires_deletion = "delete" in user_intent_lower or "remove" in user_intent_lower

# Select the active schema
ActiveSchema = RefactorProposalUnsafe if requires_deletion else RefactorProposalSafe

# Pass ActiveSchema to your generation function
# e.g., response = generate_streaming_json(prompt, schema=ActiveSchema)

```

---

### Phase 2: Differential Static Analysis (Solving Over-Strict Verification)

**The Problem:** Test 9 (Docstrings) failed because our `validate_virtual_workspace` function ran `mypy` across the entire project scope. Legacy monoliths already have hundreds of type errors, causing RepoOS to reject perfectly valid LLM patches.
**The Fix:** We must restrict `mypy` to only analyze the files that were touched in the current transaction.

**Step 1:** Update `validate_virtual_workspace` to accept `modified_paths`.

```python
import subprocess
import os
from typing import Dict, List, Tuple

def validate_virtual_workspace(state: Dict[str, str], modified_paths: List[str]) -> Tuple[bool, str]:
    """Runs mypy ONLY on the files that were modified to prevent legacy errors from blocking."""
    # ... (assume tmpdir setup is here and state is dumped to disk) ...
    
    try:
        # Construct absolute paths for only the modified files
        target_files = [os.path.join(tmpdir, p) for p in modified_paths if p in state]
        
        if not target_files:
            return True, "" # Nothing to lint
            
        # Run mypy only on target_files
        result = subprocess.run(
            [VENV_PYTHON, "-m", "mypy", *target_files, "--ignore-missing-imports", "--follow-imports=silent"],
            capture_output=True, text=True, check=False
        )
        
        if result.returncode != 0:
            return False, f"Type Error introduced in modified files:\n{result.stdout}"
            
        return True, ""
    finally:
        pass # Cleanup tmpdir

```

---

### Phase 3: Explicit `MoveNode` Dependency Injection

**The Problem:** In Test 1, `MoveNode` worked, but the LLM failed to emit a subsequent `AddImport` task, resulting in a `NameError` in the new file.
**The Fix:** Force the LLM to provide required imports inside the `MoveNode` schema, and have Python automatically inject them.

**Step 1:** Update the `MoveNode` Pydantic model.

```python
class MoveNode(BaseModel):
    action: Literal["move_node"] = "move_node"
    source_file: str
    target_file: str
    node_signature: str
    required_imports: List[str] = Field(
        default=[], 
        description="List of import statements required for this node to run in the target file (e.g., ['import csv', 'from typing import Any'])."
    )

```

**Step 2:** Update `apply_actions_to_state` to inject the imports.

```python
# Inside apply_actions_to_state, under the `if action.action == "move_node":` branch
if target_path not in new_state:
    new_state[target_path] = ""

# Construct the import block
import_block = ""
if action.required_imports:
    import_block = "\n".join(action.required_imports) + "\n\n"

# Prepend imports and append the moved node code
existing_content = new_state.get(target_path, "")
# Avoid duplicating imports if they already exist
if import_block.strip() not in existing_content:
    new_state[target_path] = import_block + existing_content + "\n\n" + node_code
else:
    new_state[target_path] = existing_content + "\n\n" + node_code

```

---

### Phase 4: Atomic "Best Effort" Execution

**The Problem:** Currently, if the model fails to resolve a syntax error after `max_retries`, the script uses `return`, aborting the entire session and discarding all valid tasks completed prior.
**The Fix:** Treat each task as an isolated atomic transaction. Skip failures, persist successes.

**Step 1:** Change `return` to `continue` in your orchestration loop.

```python
# Inside your main task processing loop (e.g., iterating over parsed Plan steps)
for i, task in enumerate(task_list):
    retry_count = 0
    success = False
    
    while retry_count < max_retries:
        try:
            # ... (generate patch, apply actions, validate) ...
            success = True
            break # Validation passed, break retry loop
            
        except (ValueError, SyntaxError) as e:
            # ... (append error to message history) ...
            retry_count += 1
            
    if not success:
        print(f"❌ Task {i+1} failed after {max_retries} attempts. Skipping to next task.")
        # CRITICAL FIX: Do not use `return` here. Use `continue` to move to the next task.
        continue 
        
    print(f"✅ Task {i+1} applied successfully.")

```

# Phase 3.4 : Hardening (3.4)

# ENGINEERING BRIEF: Hardening the Execution Engine

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Implementing Baseline Linting, Graph-Automated Imports, and AST Conservation

Please implement the following four upgrades into `refactor2.py` and the MCP tools.

---

### Phase 1: Baseline Differential Linting

**Task:** Upgrade `validate_virtual_workspace` to ignore pre-existing type errors.

```python
import subprocess
import os

def get_mypy_errors(filepath: str) -> set:
    """Runs mypy and returns a set of error strings, ignoring line numbers for baseline comparison."""
    result = subprocess.run(
        ["python", "-m", "mypy", filepath, "--ignore-missing-imports", "--follow-imports=silent"],
        capture_output=True, text=True, check=False
    )
    # Strip line numbers so we can compare the exact error signatures
    errors = set()
    for line in result.stdout.splitlines():
        if "error:" in line:
            # Extract everything after "error:" to ignore line shifts
            errors.add(line.split("error:")[1].strip())
    return errors

def validate_virtual_workspace(state: dict, modified_paths: list, pre_state_cache: dict) -> tuple[bool, str]:
    # 1. Get Baseline Errors (run on the pre_state_cache versions of the files)
    # 2. Get Post-Patch Errors (run on the newly modified tmpdir files)
    
    for path in modified_paths:
        baseline_errors = get_mypy_errors(pre_state_cache[path])
        new_errors = get_mypy_errors(os.path.join(tmpdir, path))
        
        # Find strictly new errors that didn't exist in the baseline
        introduced_errors = new_errors - baseline_errors
        
        if introduced_errors:
            return False, f"Type Error(s) introduced: {introduced_errors}"
            
    return True, ""

```

### Phase 2: Graph-Automated Downstream Imports

**Task:** Remove the burden of updating downstream imports from the LLM.

```python
# Inside apply_actions_to_state for MoveNode:
# 1. Execute the move (copy node to target_file, delete from source_file)
# ...

# 2. Query Neo4j to find downstream consumers
node_name = extract_name_from_signature(action.node_signature)
cypher_query = f"""
MATCH (f:File)-[:IMPORTS]->(n:Node {{name: '{node_name}'}})
RETURN f.path
"""
# Assume `execute_graph_query` fetches this from Neo4j
affected_files = execute_graph_query(cypher_query)

# 3. Deterministic Python string replacement
old_module_path = path_to_python_module(action.source_file) # e.g., oscar.core.compat
new_module_path = path_to_python_module(action.target_file) # e.g., oscar.core.csv_utils

for file_path in affected_files:
    if file_path in master_state:
        content = master_state[file_path]
        # Replace the old import with the new one
        updated_content = content.replace(
            f"from {old_module_path} import {node_name}", 
            f"from {new_module_path} import {node_name}"
        )
        new_state[file_path] = updated_content

```

### Phase 3: AST Volume Conservation Guardrail

**Task:** Prevent the LLM from replacing massive classes with dummy simplifications.

```python
# Inside the ModifyNode action logic:
original_node_text = extract_node_from_ast(master_state[path], action.node_signature)

# Calculate volume
orig_len = len(original_node_text.strip())
new_len = len(action.proposed_replace_string.strip())

# If the new code is less than 50% the size of the old code, raise an alarm
if new_len < (orig_len * 0.5):
    # Check if the user explicitly asked to delete/remove code
    if "remove" not in user_intent.lower() and "delete" not in user_intent.lower():
        raise ValueError(
            "Action Rejected: AST Volume Conservation Check failed. "
            "You attempted to replace a large block of code with a significantly smaller one. "
            "Do not use dummy implementations or placeholders."
        )

```

### Phase 4: Pydantic Anti-Hallucination Validators

**Task:** Block placeholder paths directly at the schema validation layer.

```python
from pydantic import BaseModel, field_validator

class CreateFile(BaseModel):
    action: str = "create_file"
    file_path: str
    content: str
    
    @field_validator('file_path')
    def validate_paths(cls, v):
        forbidden_substrings = ["path/to", "your/file", "source/file"]
        if any(sub in v.lower() for sub in forbidden_substrings):
            raise ValueError(f"Invalid path hallucination detected: {v}. You MUST output exact repository paths.")
        return v

```

# Milestone 3.5 : The Final Primitives

This is the final hurdle. Pushing 20 complex, multi-file refactoring prompts through a local 14B parameter model and achieving these results is a massive testament to your team's architecture.

By analyzing Suite 3.4, we can see exactly why the tool failed in the back half (Prompts 11-20). The LLM isn't "stupid"—it is simply being constrained by an incomplete AST parser and missing tool primitives.

Specifically:

1. **The Node Identification Bug (Tests 12, 14, 15, 17, 20):** Your `find_node_range` function is broken for class methods. If the LLM asks to modify `AbstractAddress.as_text`, your Tree-sitter query searches for a function named exactly `AbstractAddress.as_text`, which doesn't exist (the AST identifier is just `as_text` nested inside `AbstractAddress`).
2. **Creation vs Modification (Tests 11, 13, 15):** The LLM tries to `ModifyNode` on functions that don't exist yet because it has no `InsertNode` tool.
3. **Hallucination Loops:** The model defaults to dummy logic (`f'{amount:.2f}'`) or placeholder paths (`path/to/file.py`) when it runs out of tokens or gets confused.

Here is the exact, comprehensive Engineering Brief to hand to your Senior Engineer. It combines "The Final Primitives" with the fixes for the AST parsing and hallucination bugs identified in Tests 11-20.

---

# ENGINEERING BRIEF: The "Last Mile" Refactor Stability Patch

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Finalizing Repo OS Action Primitives & AST Resolution (Suite 3.4 Fixes)
**Context:** Our 14B model is hitting a structural ceiling. It fails to identify nested class methods, hallucinates paths when confused, and attempts to modify nodes that haven't been created yet. We are deploying the final Pydantic primitives (`InsertNode`, `UpdateDocstring`), fixing the Tree-sitter method resolution, and hardening the path validators.

Please implement the following five phases into `refactor2.py`.

---

### Phase 1: Fixing AST Method Resolution (Fixes Tests 12, 14, 15, 17, 20)

**The Problem:** `find_node_range` fails when given a dot-notation signature (e.g., `AbstractAddress.as_text`) because the raw Tree-sitter identifier is just `as_text`.
**Task:** Upgrade `find_node_range` to dynamically build a nested Tree-sitter query if a `.` is detected in the signature.

```python
def find_node_range(source_code: str, signature: str) -> Optional[tuple[int, int]]:
    """Uses tree-sitter to find the byte range of a function, class, or nested method."""
    tree = parser.parse(bytes(source_code, "utf8"))

    # Handle Nested Class Methods (e.g., 'AbstractAddress.as_text')
    if "." in signature:
        class_name, method_name = signature.split(".", 1)
        query = PY_LANGUAGE.query(f"""
        (class_definition 
            name: (identifier) @cls_name (#eq? @cls_name "{class_name}")
            body: (block
                (function_definition 
                    name: (identifier) @meth_name (#eq? @meth_name "{method_name}")
                ) @def
            )
        )
        """)
    # Handle Global Functions or Classes
    else:
        query = PY_LANGUAGE.query(f"""
        (function_definition name: (identifier) @name (#eq? @name "{signature}")) @def
        (class_definition name: (identifier) @name (#eq? @name "{signature}")) @def
        """)

    captures = query.captures(tree.root_node)
    if isinstance(captures, dict):
        nodes = captures.get('def', [])
        if nodes: return nodes[0].start_byte, nodes[0].end_byte
    elif captures:
        for node, name in captures:
            if name == 'def': return node.start_byte, node.end_byte
    return None

```

---

### Phase 2: The Final Primitives (Fixes Tests 4, 9, 11, 13)

**The Problem:** The LLM lacks tools to append code to existing files or cleanly update docstrings without tripping the Volume Conservation check.
**Task:** Add `InsertNode` and `UpdateDocstring` to the Pydantic schemas, and implement their logic.

**1. Add to Pydantic Models:**

```python
class InsertNode(BaseModel):
    action: Literal["insert_node"] = "insert_node"
    file_path: str = Field(..., description="Path to the existing file.")
    new_node_code: str = Field(..., description="The complete code for the new function or class.")

class UpdateDocstring(BaseModel):
    action: Literal["update_docstring"] = "update_docstring"
    file_path: str = Field(..., description="Path to the file.")
    target_node_signature: str = Field(..., description="The function or class name.")
    new_docstring: str = Field(..., description="The new docstring text, including quotes.")

# IMPORTANT: Ensure these are added to both RefactorProposalSafe and RefactorProposalUnsafe Unions!

```

**2. Execution Logic in `apply_actions_to_state`:**

```python
        elif action.action == "insert_node":
            if path not in new_state: continue
            content = new_state[path]
            # Safely append to EOF
            new_state[path] = content.rstrip() + "\n\n" + action.new_node_code + "\n"
            print(f"   ➕ Inserted new node into {path}")

        elif action.action == "update_docstring":
            if path not in new_state: continue
            content = new_state[path]
            node_range = find_node_range(content, action.target_node_signature)
            
            if node_range:
                start, end = node_range
                node_code = content[start:end]
                # Regex to safely replace or insert docstring just after the def/class signature
                pattern = re.compile(r'(^(?:[ \t]*)(?:def|class)\s+[^\:]+\:\s*\n)(?:[ \t]*[\'"]{3}.*?[\'"]{3}\s*\n)?', re.DOTALL | re.MULTILINE)
                
                def replacement(match):
                    signature_line = match.group(1)
                    indent = match.group(1).split(match.group(1).lstrip())[0] + "    " 
                    return f"{signature_line}{indent}{action.new_docstring}\n"
                
                updated_node = pattern.sub(replacement, node_code, count=1)
                new_state[path] = content[:start] + updated_node + content[end:]
                print(f"   📝 Updated docstring for {action.target_node_signature}")

```

---

### Phase 3: Pydantic Path Hardening (Fixes Tests 13, 16, 19)

**The Problem:** The LLM hallucinates paths (e.g., `oscar/apps/checkout/src/exceptions.py`).
**Task:** Upgrade `validate_no_placeholder_paths` using Pydantic V2 `@field_validator` string matching to trap hallucinations mathematically.

```python
def validate_no_placeholder_paths(v: str) -> str:
    forbidden_substrings = ["path/to", "your/file", "source/file", "target/file", "...", "<", "my_module"]
    v_lower = v.lower()
    
    for sub in forbidden_substrings:
        if sub in v_lower:
            raise ValueError(f"Invalid path hallucination detected: '{v}'. You MUST output exact repository paths from the context.")
            
    # Traversal attack / bad structure protection
    if '..' in v or v.startswith('/'):
        raise ValueError("Path must be a relative repository path, no absolute paths or traversal.")
        
    return v

```

---

### Phase 4: Dynamic Schema Pruning & Import Cleanup (Fixes Tests 1 & 10)

**Task 1: Fix `DeleteFile` Bias**
Update the intent parser (around line 2931) to use strict regex so it doesn't arm the `delete_file` tool just because the user said "remove comments".

```python
user_intent_lower = intent.lower()
# Only allow DeleteFile if they explicitly ask to delete a FILE or MODULE.
requires_deletion = bool(re.search(r'\b(delete|remove|drop)\s+(the\s+)?(file|module|script)\b', user_intent_lower))
ActiveSchema = RefactorProposalUnsafe if requires_deletion else RefactorProposalSafe

```

**Task 2: Robust Downstream Imports**
In `apply_actions_to_state` for `move_node`, update the string replacement (around line 2795) to remove the old import entirely.

```python
        if old_import in content:
            # Replace the old import line entirely, leaving the new one
            new_state[file_path] = content.replace(old_import + "\n", "")
            new_state[file_path] = new_state[file_path].replace(old_import, "")
            # Add the new import to the top of the file
            new_state[file_path] = new_import + "\n" + new_state[file_path]

```

---

### Phase 5: The Ultimate System Prompt Upgrade

**The Problem:** The LLM uses `ModifyNode` to change `min()` logic to `>=` (Test 17) or uses it on non-existent functions.
**Task:** Replace your current `sys_prompt` with this strict, behavior-modifying instruction set.

```python
sys_prompt = (
    "You are an elite Principal AI Engineer refactoring a complex Python monolith. "
    "You will be provided with a strict sub-tree of the codebase. "
    "CRITICAL RULES: \n"
    "1. NO TOKEN LAZINESS: If you use 'modify_node', you MUST output the entire, unbroken, executable code for that node. Never use '# existing code' or dummy implementations like `pass`.\n"
    "2. CREATION vs MODIFICATION: If you need to add a NEW function or class to an existing file, you MUST use 'insert_node'. Do NOT use 'modify_node' for nodes that do not exist yet.\n"
    "3. DOCSTRINGS: To update a docstring on a large class, use 'update_docstring'. Do not rewrite the whole class just to change documentation.\n"
    "4. LOGIC PRESERVATION: When extracting logic or adding type hints, DO NOT alter the underlying functional business logic. (e.g. do not change a `min()` check to `>=`).\n"
    "5. IMPORTS: Always use 'add_import' if your new code requires dependencies like 'typing', 'Decimal', or 'settings'.\n"
)

```