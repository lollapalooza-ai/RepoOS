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

# Milestone 3.6 : Finalizing AST Robustness & Indentation

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Patching AST Parsing, Indentation Math, and Cross-Task Consistency (Suite 3.5)

Please implement these four precise upgrades into `refactor2.py`.

#### Phase 1: Expanding Tree-Sitter Node Resolution (Fixes Tests 12, 14, 17)

**Task:** Upgrade `find_node_range` to detect decorated methods, async methods, and properties.

```python
def find_node_range(source_code: str, signature: str) -> Optional[tuple[int, int]]:
    """Uses tree-sitter to find the byte range of a function, class, nested method, or decorated property."""
    tree = parser.parse(bytes(source_code, "utf8"))

    if "." in signature:
        class_name, method_name = signature.split(".", 1)
        # Capture standard, decorated, and async methods inside classes
        query = PY_LANGUAGE.query(f"""
        (class_definition 
            name: (identifier) @cls_name (#eq? @cls_name "{class_name}")
            body: (block
                [
                    (function_definition name: (identifier) @meth_name (#eq? @meth_name "{method_name}"))
                    (decorated_definition (function_definition name: (identifier) @meth_name (#eq? @meth_name "{method_name}")))
                    (async_function_definition name: (identifier) @meth_name (#eq? @meth_name "{method_name}"))
                ] @def
            )
        )
        """)
    else:
        # Capture global level definitions
        query = PY_LANGUAGE.query(f"""
        (function_definition name: (identifier) @name (#eq? @name "{signature}")) @def
        (class_definition name: (identifier) @name (#eq? @name "{signature}")) @def
        (decorated_definition (function_definition name: (identifier) @name (#eq? @name "{signature}"))) @def
        (async_function_definition name: (identifier) @name (#eq? @name "{signature}")) @def
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

#### Phase 2: Dynamic Indentation Normalization (Fixes Tests 5, 9, 20)

**Task:** `UpdateDocstring` and `InsertNode` must mathematically calculate the target indentation rather than relying on the LLM's whitespace.
**1. Inject this helper function:**

```python
import textwrap

def get_base_indent(source_code: str, byte_offset: int) -> str:
    """Finds the whitespace indentation level at a specific byte offset."""
    lines = source_code[:byte_offset].split('\n')
    last_line = lines[-1] if lines else ""
    return last_line[:-len(last_line.lstrip())]

```

**2. Update `apply_actions_to_state` for `insert_node`:**

```python
        elif action.action == "insert_node":
            if path not in new_state: continue
            content = new_state[path]
            
            # If inserting a method into a class (detected by dot notation in the prompt/context)
            if "." in getattr(action, 'target_class_signature', ""):
                class_range = find_node_range(content, action.target_class_signature)
                if class_range:
                    _, end = class_range
                    # Calculate class indent + 4 spaces
                    base_indent = get_base_indent(content, class_range[0]) + "    "
                    normalized_code = textwrap.indent(textwrap.dedent(action.new_node_code), base_indent)
                    
                    # Insert right before the end of the class block
                    new_state[path] = content[:end] + "\n" + normalized_code + "\n" + content[end:]
                    print(f"   ➕ Inserted method into {action.target_class_signature}")
                    continue
            
            # Fallback: Append to EOF with no indent
            new_state[path] = content.rstrip() + "\n\n" + textwrap.dedent(action.new_node_code) + "\n"
            print(f"   ➕ Inserted new node into {path}")

```

#### Phase 3: Pydantic Schema Upgrades (Fixes Tests 11, 13, 15)

**Task:** We must force the LLM to explicitly state if an `InsertNode` belongs inside a class.

**Update the model in `refactor2.py**`:

```python
class InsertNode(BaseModel):
    action: Literal["insert_node"] = "insert_node"
    file_path: str = Field(..., description="Path to the existing file.")
    new_node_code: str = Field(..., description="The complete code for the new function or class.")
    target_class_signature: Optional[str] = Field(None, description="If inserting a method into an existing class, provide the class name here (e.g., 'AbstractOrder'). Leave null for global functions.")

```

#### Phase 4: System Prompt Reinforcement (Fixes Test 4, 6, 18, 19)

**Task:** The LLM's system prompt needs a direct command to stop hallucinating dummy logic and to manage `MoveNode` volume blocks.

**Update `sys_prompt` around line 1263:**

```python
sys_prompt = (
    "You are an elite Principal AI Engineer refactoring a complex Python monolith. "
    "You will be provided with a strict sub-tree of the codebase. "
    "CRITICAL RULES: \n"
    "1. NO DUMMY LOGIC: When extracting or moving logic, you MUST preserve the exact original business logic. Do not simplify logic with placeholders like `f'{amount:.2f}'`.\n"
    "2. STRICT TOOL CHOICE: To add a NEW method to an existing class, you MUST use 'insert_node' and set 'target_class_signature'. DO NOT use 'modify_node' for nodes that don't exist yet.\n"
    "3. CONSISTENCY: Ensure variable names, setting keys, and custom exceptions match exactly across all files in your plan.\n"
    "4. MOVE VS DELETE: If moving a class to a new file, ALWAYS use 'move_node'. Do not use 'modify_node' to delete it from the source file.\n"
    "5. IMPORTS: Always use 'add_import' if your new code requires dependencies like 'typing', 'Decimal', or 'settings'. Ensure imports use exact project absolute paths (e.g., 'oscar.core.utils').\n"
)

```
# Milestone 3.6.1 : The Repo OS "Last Mile" Architecture Patch

# ENGINEERING BRIEF

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Master Patch - Suite 3.4 & 3.5 Fixes (AST Parsing, Graph Inheritance, and Final Primitives)
**Context:** Our local 14B model has reached the limits of its zero-shot context window and toolset. To achieve 90%+ reliability on complex multi-file refactors, we must supply it with proper node insertion primitives, mathematically precise indentation handlers, and an upgraded RAG context pipeline that resolves class inheritance dynamically.

Please implement the following architectural upgrades across `ingest2.py` and `refactor2.py`.

---

## PART A: Knowledge Graph & Context Routing

### 1. Upgrade `ingest2.py`: AST Sync & Inheritance Mapping

We must ensure the graph captures decorated methods (like `@property`) and class inheritance so the MCP tools can query them.

**Update Tree-sitter Queries & Processing:**

```python
# 1. Expand function extraction to include decorators and async
FUNCTION_QUERY = PY_LANGUAGE.query("""
    [
        (function_definition name: (identifier) @function.name)
        (async_function_definition name: (identifier) @function.name)
        (decorated_definition (function_definition name: (identifier) @function.name))
    ] @function.def
""")

# 2. Add Class Inheritance Query
CLASS_INHERITANCE_QUERY = PY_LANGUAGE.query("""
    (class_definition
        name: (identifier) @class.name
        superclasses: (argument_list (identifier) @base.name)
    )
""")

# 3. Inside process_file(), create the edges in Neo4j:
def create_inheritance_dependency(child_class, base_class):
    query = """
    MERGE (child:Class {name: $child_class})
    MERGE (base:Class {name: $base_class})
    MERGE (child)-[:INHERITS_FROM]->(base)
    """
    execute_write_query(query, {'child_class': child_class, 'base_class': base_class})

```

### 2. Upgrade `get_hybrid_context` MCP Tool

When gathering context for a target file, traverse the new `[:INHERITS_FROM]` edge to fetch parent class signatures and docstrings.

**Update Context Builder:**

```python
def get_hybrid_context(target_file: str, class_names: List[str]) -> str:
    # ... existing vector/file context gathering ...
    
    # NEW: Fetch Parent Class Context
    parent_context_xml = ""
    for class_name in class_names:
        cypher_query = """
        MATCH (c:Class {name: $class_name})-[:INHERITS_FROM*1..2]->(parent:Class)-[:CONTAINS]->(method:Function)
        RETURN parent.name AS parent, method.name AS method, method.signature AS sig, method.docstring AS doc
        """
        results = execute_graph_query(cypher_query, {'class_name': class_name})
        
        if results:
            parent_context_xml += f"\n<parent_class_context name='{class_name}'>\n"
            for row in results:
                parent_context_xml += f"  <inherited_method parent='{row['parent']}' signature='{row['sig']}'>\n"
                parent_context_xml += f"    {row['doc']}\n  </inherited_method>\n"
            parent_context_xml += "</parent_class_context>\n"
            
    return existing_context + parent_context_xml

```

---

## PART B: Core Action Primitives (`refactor2.py`)

### 1. Introduce `InsertNode` and `UpdateDocstring` Pydantic Schemas

Give the LLM the ability to append code and update docs without rewriting 500-line classes.

```python
class InsertNode(BaseModel):
    action: Literal["insert_node"] = "insert_node"
    file_path: str = Field(..., description="Path to the existing file.")
    new_node_code: str = Field(..., description="The complete code for the new function or class.")
    target_class_signature: Optional[str] = Field(None, description="If inserting a method into an existing class, provide the class name here (e.g., 'AbstractOrder').")

class UpdateDocstring(BaseModel):
    action: Literal["update_docstring"] = "update_docstring"
    file_path: str = Field(..., description="Path to the file.")
    target_node_signature: str = Field(..., description="The function or class name.")
    new_docstring: str = Field(..., description="The new docstring text, including quotes.")

# IMPORTANT: Add these to RefactorProposalSafe and RefactorProposalUnsafe Unions!

```

### 2. Pydantic Path Hardening & Safe Schema Fallback

```python
# 1. Pydantic Validator for all file_path fields
@field_validator('file_path')
def validate_paths(cls, v):
    forbidden = ["path/to", "your/file", "source/file", "target/file", "...", "<"]
    if any(sub in v.lower() for sub in forbidden):
        raise ValueError(f"Invalid path hallucination: '{v}'. Use exact repository paths.")
    return v

# 2. Hardened DeleteFile Intent Check (in the main orchestration loop)
requires_deletion = bool(re.search(r'\b(delete|remove|drop)\s+(the\s+)?(file|module|script)\b', intent.lower()))
ActiveSchema = RefactorProposalUnsafe if requires_deletion else RefactorProposalSafe

```

---

## PART C: AST Execution & Indentation (`refactor2.py`)

### 1. Upgrade `find_node_range` (Nested & Decorated Methods)

Update the Tree-sitter query to catch dotted signatures (`Class.method`) and decorated properties.

```python
def find_node_range(source_code: str, signature: str) -> Optional[tuple[int, int]]:
    tree = parser.parse(bytes(source_code, "utf8"))

    if "." in signature:
        class_name, method_name = signature.split(".", 1)
        query = PY_LANGUAGE.query(f"""
        (class_definition name: (identifier) @cls (#eq? @cls "{class_name}")
            body: (block [
                (function_definition name: (identifier) @meth (#eq? @meth "{method_name}"))
                (decorated_definition (function_definition name: (identifier) @meth (#eq? @meth "{method_name}")))
            ] @def )
        )
        """)
    else:
        query = PY_LANGUAGE.query(f"""
        (function_definition name: (identifier) @n (#eq? @n "{signature}")) @def
        (class_definition name: (identifier) @n (#eq? @n "{signature}")) @def
        (decorated_definition (function_definition name: (identifier) @n (#eq? @n "{signature}"))) @def
        """)
    # ... (capture parsing remains the same) ...

```

### 2. Dynamic Indentation Normalization

To prevent `SyntaxError: expected an indented block` when inserting nodes into classes.

```python
import textwrap

def get_base_indent(source_code: str, byte_offset: int) -> str:
    """Calculates the whitespace prefix of the line at the given offset."""
    lines = source_code[:byte_offset].split('\n')
    last_line = lines[-1] if lines else ""
    return last_line[:-len(last_line.lstrip())]

# Inside apply_actions_to_state for 'insert_node':
        elif action.action == "insert_node":
            content = new_state.get(path, "")
            
            if getattr(action, 'target_class_signature', None):
                class_range = find_node_range(content, action.target_class_signature)
                if class_range:
                    _, end = class_range
                    base_indent = get_base_indent(content, class_range[0]) + "    "
                    normalized_code = textwrap.indent(textwrap.dedent(action.new_node_code), base_indent)
                    
                    new_state[path] = content[:end] + "\n" + normalized_code + "\n" + content[end:]
                    continue
            
            new_state[path] = content.rstrip() + "\n\n" + textwrap.dedent(action.new_node_code) + "\n"

```

---

## PART D: System Prompt Reinforcement

Update `sys_prompt` to forbid dummy logic and enforce the new tools.

```python
sys_prompt = (
    "You are an elite Principal AI Engineer refactoring a complex Python monolith. "
    "You will be provided with a strict sub-tree of the codebase. "
    "CRITICAL RULES: \n"
    "1. NO DUMMY LOGIC: When extracting or modifying code, preserve the EXACT original business logic. Never use placeholders like `pass` or `f'{amount}'`.\n"
    "2. INSERT VS MODIFY: To add a NEW method to an existing class, use 'insert_node' and set 'target_class_signature'. DO NOT use 'modify_node' for nodes that don't exist yet.\n"
    "3. DOCSTRINGS: To update documentation on a large class, use 'update_docstring'. Do not rewrite the whole class.\n"
    "4. INHERITANCE: Review the <parent_class_context> provided. Do not duplicate parent logic unnecessarily.\n"
    "5. IMPORTS: Always use 'add_import' for new dependencies. Use exact project absolute paths.\n"
)

```

# Milestone 3.6.2: Hardening the AST Edge Cases (Suite 3.6 Fixes)

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Patching AST Strictness, Volume Traps, and Import Routing

Please implement these four precise, copy-pasteable upgrades into `refactor2.py`.

### Phase 1: Fixing the Import Routing Bug

**Task:** Stop `path_to_python_module`  from destroying the Django app namespace.

* **Implementation:**

```python
def path_to_python_module(filepath: str) -> str:
    """Converts a file path to a python module path without destroying app namespaces."""
    path = filepath
    if path.endswith(".py"): path = path[:-3]
    
    # ONLY strip src/ or other top-level project wrappers. 
    # Do NOT strip 'oscar/' as that is the actual root package namespace.
    if path.startswith("src/"):
        path = path[4:]
        
    return path.replace("/", ".").replace("\\", ".")

```

### Phase 2: Node Signature Sanitization

**Task:** Upgrade `find_node_range`  to ignore parameters if the LLM hallucinates the full function signature instead of just the name.

* **Implementation:**

```python
def find_node_range(source_code: str, signature: str) -> Optional[tuple[int, int]]:
    """Uses tree-sitter to find the byte range, sanitizing LLM hallucinations."""
    # Fix: Strip out anything after '(' so 'get_model(arg1, arg2)' becomes 'get_model'
    clean_sig = signature.split('(')[0].strip()
    
    tree = parser.parse(bytes(source_code, "utf8"))

    if "." in clean_sig:
        class_name, method_name = clean_sig.split(".", 1)
        query = PY_LANGUAGE.query(f"""
        (class_definition name: (identifier) @cls (#eq? @cls "{class_name}")
            body: (block [
                (function_definition name: (identifier) @meth (#eq? @meth "{method_name}"))
                (decorated_definition (function_definition name: (identifier) @meth (#eq? @meth "{method_name}")))
                (async_function_definition name: (identifier) @meth (#eq? @meth "{method_name}"))
            ] @def )
        )
        """)
    else:
        query = PY_LANGUAGE.query(f"""
        (function_definition name: (identifier) @n (#eq? @n "{clean_sig}")) @def
        (class_definition name: (identifier) @n (#eq? @n "{clean_sig}")) @def
        (decorated_definition (function_definition name: (identifier) @n (#eq? @n "{clean_sig}"))) @def
        (async_function_definition name: (identifier) @n (#eq? @n "{clean_sig}")) @def
        """)
    # [cite_start]... (capture parsing remains the same [cite: 893]) ...

```

### Phase 3: The "Extract" Volume Bypass

**Task:** Update the Volume Conservation Guardrail  to allow massive size reductions when the user's intent is to extract or split logic.

* **Implementation:** (Replace lines 1010-1018)

```python
        # If the new code is less than 50% the size of the old code, raise an alarm
        if orig_len > 100 and new_len < (orig_len * 0.5):
            # Whitelist intents that legitimately shrink code volume
            allowed_intents = ["remove", "delete", "extract", "move", "split", "break down"]
            if not any(word in intent.lower() for word in allowed_intents):
                raise ValueError(
                    f"Action Rejected: AST Volume Conservation Check failed for '{action.target_node_signature}'. "
                    f"You attempted to replace a large block of code ({orig_len} chars) with a significantly smaller one ({new_len} chars). "
                    "Do not use dummy implementations or placeholders. Write the COMPLETE executable code."
                )

```

### Phase 4: Robust Docstring Regex

**Task:** Make `UpdateDocstring`  impervious to trailing inline comments on class/function definitions.

* **Implementation:** (Replace the regex on line 1126)

```python
            # Regex to safely replace or insert docstring just after the def/class signature
            # Fix: [^\n]*\n handles trailing comments like 'def foo(): # comment \n'
            pattern = re.compile(r'(^(?:[ \t]*)(?:def|async def|class)\s+[^:]+:[^\n]*\n)(?:[ \t]*[\'"]{3}.*?[\'"]{3}\s*\n)?', re.DOTALL | re.MULTILINE)

```

# Milestone 3.6.3 Hardening Indentation & Extraction Logic

# ENGINEERING BRIEF: Hardening Indentation & Extraction Logic (Suite 3.6.2 Fixes)

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Patching Indentation Math, Volume Bypass, and Free-Floating Nodes

Please implement these four upgrades into `refactor2.py` to resolve the final friction points.

### Phase 1: Robust Indentation Math

**Task:** Stop calculating indentation based on the preceding line. Calculate it based on the AST definition line of the parent node.
**Implementation:** Update `get_base_indent` and the `insert_node` / `update_docstring` logic.

```python
def get_node_indent(source_code: str, start_byte: int) -> str:
    """Calculates the exact indentation of the line where a node starts."""
    # Find the start of the line containing the start_byte
    line_start = source_code.rfind('\n', 0, start_byte) + 1
    line_text = source_code[line_start:start_byte]
    # Return just the whitespace
    return line_text[:-len(line_text.lstrip())]

# Inside apply_actions_to_state for 'insert_node':
        elif action.action == "insert_node":
            content = new_state.get(path, "")
            
            if getattr(action, 'target_class_signature', None):
                class_range = find_node_range(content, action.target_class_signature)
                if class_range:
                    class_start, class_end = class_range
                    # The new method's indent is exactly the class's indent + 4 spaces
                    base_indent = get_node_indent(content, class_start) + "    "
                    normalized_code = textwrap.indent(textwrap.dedent(action.new_node_code), base_indent)
                    
                    new_state[path] = content[:class_end] + "\n" + normalized_code + "\n" + content[class_end:]
                    continue

```

### Phase 2: Resolving the "Empty Extraction" Trap

**Task:** The Volume Conservation check must whitelist operations that are explicitly moving or extracting logic, so the LLM doesn't feel forced to create empty methods to bypass the alarm.

**Implementation:** Update the `modify_node` volume check bypass.

```python
        # Phase 3: AST Volume Conservation Guardrail
        # ... (orig_len and new_len calculation) ...
        
        if orig_len > 100 and new_len < (orig_len * 0.5):
            # Whitelist intents that legitimately shrink code volume
            allowed_intents = ["remove", "delete", "extract", "move", "split", "break down", "delegate"]
            # Also check if the LLM is explicitly calling a new helper method
            is_calling_helper = "def " not in action.proposed_replace_string and "(" in action.proposed_replace_string
            
            if not any(word in intent.lower() for word in allowed_intents) and not is_calling_helper:
                raise ValueError(
                    f"Action Rejected: AST Volume Conservation Check failed for '{action.target_node_signature}'. "
                    f"You attempted to replace a large block of code with a significantly smaller one. "
                    "Do not use dummy implementations (like 'pass'). Write the COMPLETE executable code."
                )

```

### Phase 3: The `DeleteLines` Primitive (For Free-Floating Nodes)

**Task:** Give the LLM a way to delete registration calls or module-level execution lines that aren't wrapped in a function, which `MoveNode` leaves behind.

**Implementation:** Add a regex-based `DeleteLines` action to the Pydantic schema.

```python
class DeleteLines(BaseModel):
    action: Literal["delete_lines"] = "delete_lines"
    file_path: str = Field(..., description="Path to the file.")
    exact_string_match: str = Field(..., description="The exact line(s) of code to delete (e.g., 'Field.register_lookup(ReverseStartsWith)').")

# Add to the Action Unions, then in apply_actions_to_state:
        elif action.action == "delete_lines":
            if path in new_state:
                content = new_state[path]
                if action.exact_string_match in content:
                    new_state[path] = content.replace(action.exact_string_match, "")
                    # Clean up blank lines left behind
                    new_state[path] = re.sub(r'\n\s*\n', '\n\n', new_state[path])
                    print(f"   ✂️ Deleted specified lines from {path}")

```

### Phase 4: System Prompt - Forcing Extraction Completion

**Task:** Stop the LLM from hallucinating `self` in static contexts and force it to complete extractions.

**Implementation:** Append these rules to the `sys_prompt`.

```python
    "6. EXTRACTION COMPLETENESS: If you are asked to extract logic, you MUST create the new utility function WITH the full logic, and you MUST update the original caller to use the new function. Do not leave either empty.\n"
    "7. SCOPE AWARENESS: Do not use `self` inside global utility functions or static decorators unless explicitly passed as an argument.\n"

```

# Milestone 3.6.4 The CST Migration & Linter-in-the-Loop

# ENGINEERING BRIEF: The CST Migration & Linter-in-the-Loop (Suite 3.6.3)

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Migrating to LibCST for Immutable Decorators and Indentation Safety
**Context:** Our string-based AST manipulation is causing unrecoverable indentation loops and allowing the LLM to accidentally destroy Django decorators (like `@transaction.atomic`) when modifying nodes. We are migrating `InsertNode` and `ModifyNode` to `LibCST` to mathematically guarantee whitespace formatting and decorator preservation, backed by a `ruff` pre-formatting loop.

Please install the dependencies (`pip install libcst ruff`), and implement the following three phases into `refactor2.py`.

---

### Phase 1: The Linter-in-the-Loop (`ruff format`)

**Task:** Intercept the LLM's raw output and run it through `ruff` in memory to fix any trailing commas or minor whitespace errors *before* Pyflakes validation.

```python
import subprocess
import ast
import io
import pyflakes.api
import pyflakes.reporter

def format_and_validate_python(content: str, filepath: str = "temp.py") -> tuple[bool, str, str]:
    """Runs ruff to auto-format, then pyflakes to validate semantics."""
    # 1. Linter-in-the-Loop: Auto-format with Ruff
    try:
        ruff_result = subprocess.run(
            ["ruff", "format", "-", "--stdin-filename", filepath],
            input=content,
            text=True,
            capture_output=True,
            check=True
        )
        formatted_content = ruff_result.stdout
    except subprocess.CalledProcessError as e:
        return False, f"Ruff Formatting Error: {e.stderr}", content

    # 2. Syntax Check (Sanity)
    try:
        ast.parse(formatted_content)
    except SyntaxError as e:
        return False, f"SyntaxError: {str(e)}", formatted_content
    
    # 3. Semantic Check (NameErrors / missing imports)
    output = io.StringIO()
    reporter = pyflakes.reporter.Reporter(output, output)
    pyflakes.api.check(formatted_content, filepath, reporter)
    
    errors = output.getvalue()
    if "undefined name" in errors:
        return False, f"Missing Import detected: {errors.strip()}. You MUST use 'add_import'.", formatted_content
    
    return True, "", formatted_content

```

---

### Phase 2: LibCST Insertion Engine

**Task:** Migrate `InsertNode` to `LibCST` so it inherently calculates class-level indentation.

```python
import libcst as cst

class InsertMethodTransformer(cst.CSTTransformer):
    """Cleanly injects a new method into an existing class, handling indentation natively."""
    def __init__(self, target_class_name: str, new_method_code: str):
        self.target_class_name = target_class_name
        self.new_method_node = cst.parse_statement(new_method_code)

    def leave_ClassDef(self, original_node: cst.ClassDef, updated_node: cst.ClassDef) -> cst.ClassDef:
        if original_node.name.value == self.target_class_name:
            # Append the new method; LibCST automatically aligns the whitespace!
            new_body = list(updated_node.body.body) + [self.new_method_node]
            return updated_node.with_changes(
                body=updated_node.body.with_changes(body=new_body)
            )
        return updated_node

# Integration inside apply_actions_to_state for 'insert_node'
# (See previous brief for integration logic using cst.parse_module)

```

---

### Phase 3: LibCST Modification Engine & The "Decorator Shield"

**Task:** Migrate `ModifyNode` to LibCST. Intercept the node replacement and manually copy the `decorators` attribute from the old AST node to the new LLM-generated node.

```python
class ModifyNodeTransformer(cst.CSTTransformer):
    """Replaces a function/method while mathematically guaranteeing decorator preservation."""
    def __init__(self, target_node_name: str, new_node_code: str):
        self.target_node_name = target_node_name.split('.')[-1] # Strip class prefix if present
        
        # Parse the LLM's proposed replacement logic
        parsed_module = cst.parse_module(new_node_code)
        self.new_node_ast = parsed_module.body[0]

    def leave_FunctionDef(self, original_node: cst.FunctionDef, updated_node: cst.FunctionDef) -> cst.CSTNode:
        if original_node.name.value == self.target_node_name:
            
            # THE DECORATOR SHIELD:
            # Forcibly graft the original node's decorators onto the new node.
            # This prevents the LLM from accidentally deleting @property, @atomic, etc.
            safe_new_node = self.new_node_ast.with_changes(
                decorators=original_node.decorators
            )
            return safe_new_node
            
        return updated_node

    def leave_ClassDef(self, original_node: cst.ClassDef, updated_node: cst.ClassDef) -> cst.CSTNode:
        if original_node.name.value == self.target_node_name:
            # Same shield applies to Class decorators (e.g., @dataclass)
            safe_new_node = self.new_node_ast.with_changes(
                decorators=original_node.decorators
            )
            return safe_new_node
            
        return updated_node

# Integration inside apply_actions_to_state for 'modify_node':
        elif action.action == "modify_node":
            content = new_state.get(path, "")
            try:
                source_tree = cst.parse_module(content)
                transformer = ModifyNodeTransformer(
                    target_node_name=action.target_node_signature,
                    new_node_code=action.proposed_replace_string
                )
                modified_tree = source_tree.visit(transformer)
                new_state[path] = modified_tree.code
                print(f"   🔄 [LibCST] Modified {action.target_node_signature} (Decorators Preserved)")
            except Exception as e:
                raise ValueError(f"LibCST modification failed: {e}")

```

---

### Phase 4: System Prompt Reinforcement

**Task:** Update the system prompt to inform the LLM that the execution engine handles formatting and decorators, freeing up its token budget for pure logic.

```python
sys_prompt = (
    "You are an elite Principal AI Engineer refactoring a complex Python monolith. "
    "CRITICAL RULES: \n"
    "1. FOCUS ON LOGIC: The execution engine automatically handles PEP-8 whitespace formatting and preserves existing decorators (like @property). Focus your tokens entirely on writing the correct, complete internal business logic.\n"
    "2. NO DUMMY LOGIC: When extracting or modifying code, preserve the EXACT original business logic. Never use placeholders like `pass`.\n"
    "3. INSERT VS MODIFY: To add a NEW method to an existing class, use 'insert_node' and set 'target_class_signature'. DO NOT use 'modify_node' for nodes that don't exist yet.\n"
    "4. EXTRACTION COMPLETENESS: If extracting logic, you MUST output the full extracted utility function, and you MUST update the original caller to use it.\n"
)

```

# Milestone 3.6.5 : The Autopsy of Suite 3.6.4

# ENGINEERING BRIEF: The Final Hardening (Suite 3.6.4 Fixes)

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Patching LibCST Type Safety, Line-Strict Linting, and Anti-Hallucination Constraints

Please implement these four precise upgrades into your updated `RepoOS2` code (`refactor2.py`) to eradicate the remaining failure modes.

### Phase 1: LibCST Type Safety & Native Docstrings (Fixes Tests 18, 20)

**Task 1: Fix the `decorators` kwarg crash.**
Update `ModifyNodeTransformer` to check if the new node is actually a function or class before grafting decorators.

```python
    def leave_FunctionDef(self, original_node: cst.FunctionDef, updated_node: cst.FunctionDef) -> cst.CSTNode:
        if original_node.name.value == self.target_node_name:
            # Type safety check: Ensure the LLM didn't hallucinate a non-function node
            if isinstance(self.new_node_ast, (cst.FunctionDef, cst.ClassDef)):
                return self.new_node_ast.with_changes(decorators=original_node.decorators)
            return self.new_node_ast # Return as-is if the LLM changed the node type entirely
        return updated_node

```

**Task 2: Migrate `UpdateDocstring` to LibCST.**
Stop using regex for docstrings. LibCST natively understands where docstrings belong without throwing indentation errors.

```python
# Inside apply_actions_to_state for 'update_docstring':
        elif action.action == "update_docstring":
            content = new_state.get(path, "")
            try:
                source_tree = cst.parse_module(content)
                # Parse the new docstring string into a SimpleStatementLine
                new_doc_node = cst.parse_module(f'"""{action.new_docstring.strip("""")}"""').body[0]
                
                class DocstringTransformer(cst.CSTTransformer):
                    def leave_FunctionDef(self, original_node, updated_node):
                        if original_node.name.value == action.target_node_signature.split('.')[-1]:
                            new_body = [new_doc_node] + list(updated_node.body.body)[1:] if updated_node.get_docstring() else [new_doc_node] + list(updated_node.body.body)
                            return updated_node.with_changes(body=updated_node.body.with_changes(body=new_body))
                        return updated_node
                        
                    def leave_ClassDef(self, original_node, updated_node):
                        if original_node.name.value == action.target_node_signature.split('.')[-1]:
                            new_body = [new_doc_node] + list(updated_node.body.body)[1:] if updated_node.get_docstring() else [new_doc_node] + list(updated_node.body.body)
                            return updated_node.with_changes(body=updated_node.body.with_changes(body=new_body))
                        return updated_node

                modified_tree = source_tree.visit(DocstringTransformer())
                new_state[path] = modified_tree.code
                print(f"   📝 [LibCST] Updated docstring for {action.target_node_signature}")
            except Exception as e:
                raise ValueError(f"LibCST docstring update failed: {e}")

```

### Phase 2: The Node Integrity Shield (Fixes Tests 5, 11, 17, 19)

**Task:** We must explicitly prevent the LLM from wiping core methods like `__init__`, `clean`, or `save` under the guise of "refactoring."
Add this validation check inside the `ModifyNode` execution block:

```python
        # Protected core methods shield
        protected_methods = ["__init__", "clean", "save", "dispatch"]
        target_name = action.target_node_signature.split('.')[-1]
        
        if target_name in protected_methods:
            # If it's a protected method, it must retain a super() call or be at least 80% the original size
            if "super()" not in action.proposed_replace_string and len(action.proposed_replace_string) < (orig_len * 0.8):
                raise ValueError(
                    f"Safety Block: You attempted to overwrite a critical '{target_name}' method with a fundamentally smaller implementation that lacks a super() call. "
                    f"This usually indicates an accidental wipe. You must preserve the core logic."
                )

```

### Phase 3: True Differential Linting (Fixes Tests 2, 7)

**Task:** Stop failing tasks for pre-existing errors. We must use Python's `difflib` to only run validation checks on lines that were actually changed.

```python
import difflib

def get_modified_line_numbers(old_content: str, new_content: str) -> set:
    """Returns a set of line numbers that were added or modified in the new content."""
    lines_old = old_content.splitlines()
    lines_new = new_content.splitlines()
    matcher = difflib.SequenceMatcher(None, lines_old, lines_new)
    modified_lines = set()
    
    for tag, i1, i2, j1, j2 in matcher.get_opcodes():
        if tag in ('replace', 'insert'):
            for line_num in range(j1 + 1, j2 + 1):
                modified_lines.add(line_num)
    return modified_lines

# In your Pyflakes/Linter validation loop:
    # 1. Calculate modified_lines = get_modified_line_numbers(master_state[path], new_state[path])
    # 2. Parse the pyflakes output line number (e.g. from "loading.py:45: undefined name")
    # 3. Only raise the error if that integer line number exists in the modified_lines set.

```

### Phase 4: System Prompt - Banning Relative Imports & Hallucinations (Fixes 1, 4, 6, 10, 13, 15)

**Task:** Update the System Prompt to enforce strict context boundaries.

```python
sys_prompt = (
    "You are an elite Principal AI Engineer refactoring a complex Python monolith. "
    "CRITICAL RULES: \n"
    "1. NO HALLUCINATIONS: You MUST strictly use the variables, kwargs, and attributes exactly as they appear in the provided file context. Do not invent `self.order_number` if the code uses `self.number`. Do not invent exception names.\n"
    "2. ABSOLUTE IMPORTS ONLY: Never use relative imports (like `from . import lookups`). ALL imports must be absolute paths from the project root (e.g., `from oscar.core.models import lookups`).\n"
    "3. SCOPE AWARENESS: Do not use `self` inside global utility functions, static decorators, or outside of a Class instance.\n"
    "4. NO DUMMY LOGIC: When extracting or modifying code, preserve the EXACT original business logic. Never use placeholders like `pass`.\n"
)

```

# Milestone 3.6.6 : Dual-Workspace Differential Linting

### The Architectural Shift

1. **Identical Staging:** We will create *two* temporary directories (`workspace_baseline` and `workspace_post`). We will dump the entire graph state into both, apply the LLM's patch only to the post-workspace, and run Mypy globally on both. This guarantees the import resolution environment is mathematically identical.
2. **Line-Strict Attribution:** For files the LLM modified, we will use Python's `difflib` to calculate the exact line numbers that were changed. We will only blame the LLM if a Pyflakes/Mypy error lands *specifically on a modified line*.
3. **Downstream Break Tracking:** For files the LLM *didn't* modify, we will track the frequency of specific Mypy error messages. If a new error message appears in an unmodified file in the post-workspace, we know the LLM broke a downstream dependency.

---

# ENGINEERING BRIEF: Dual-Workspace Differential Linting

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Rewriting `validate_virtual_workspace` for True Differential Line-Mapping

Please add the following helper functions and completely replace the existing `validate_virtual_workspace` in `refactor2.py`.

### Phase 1: The Helper Functions

Add these above your validation logic. They handle the exact line-number mapping and Mypy output parsing.

```python
import os
import shutil
import tempfile
import subprocess
import difflib
import re
from typing import Dict, List, Tuple, Set

def get_modified_line_numbers(old_content: str, new_content: str) -> Set[int]:
    """Returns a set of line numbers (1-indexed) modified or added in the new content."""
    lines_old = old_content.splitlines()
    lines_new = new_content.splitlines()
    matcher = difflib.SequenceMatcher(None, lines_old, lines_new)
    modified_lines = set()
    
    for tag, i1, i2, j1, j2 in matcher.get_opcodes():
        if tag in ('replace', 'insert'):
            # j1 to j2 are 0-indexed indices in lines_new. Add 1 for standard 1-indexed line numbers.
            for line_num in range(j1 + 1, j2 + 1):
                modified_lines.add(line_num)
    return modified_lines

def parse_mypy_output(stdout: str, base_dir: str) -> Dict[str, List[Tuple[int, str]]]:
    """Parses Mypy output into a dict mapping relative filepath -> list of (line_num, exact_error_message)."""
    errors = {}
    # Matches Mypy format: "filepath.py:line_num: error/note: Message [error-code]"
    pattern = re.compile(r"^(.*?):(\d+): (?:error|note): (.*)$")
    
    for line in stdout.splitlines():
        match = pattern.match(line)
        if match:
            filepath, line_num, msg = match.groups()
            # Normalize filepath relative to the temporary workspace root
            rel_path = os.path.relpath(os.path.abspath(os.path.join(base_dir, filepath)), base_dir)
            if rel_path not in errors:
                errors[rel_path] = []
            errors[rel_path].append((int(line_num), msg.strip()))
    return errors

```

### Phase 2: The Core Validation Engine

Replace your current `validate_virtual_workspace` with this dual-workspace implementation.

```python
def validate_virtual_workspace(pre_state: dict, post_state: dict, modified_paths: list) -> tuple[bool, str]:
    """
    True Differential Linting:
    1. Creates identical pre/post workspace directories.
    2. Runs Mypy globally to establish a contextual baseline.
    3. Uses line-mapping and frequency tracking to isolate LLM-introduced errors.
    """
    with tempfile.TemporaryDirectory() as base_dir, tempfile.TemporaryDirectory() as post_dir:
        
        # 1. Populate identical workspaces to guarantee identical Mypy import resolution
        for path, content in pre_state.items():
            full_path = os.path.join(base_dir, path)
            os.makedirs(os.path.dirname(full_path), exist_ok=True)
            with open(full_path, "w", encoding="utf-8") as f: f.write(content)

        for path, content in post_state.items():
            full_path = os.path.join(post_dir, path)
            os.makedirs(os.path.dirname(full_path), exist_ok=True)
            with open(full_path, "w", encoding="utf-8") as f: f.write(content)

        # 2. Run Mypy globally on BOTH workspaces
        # --show-error-codes and --hide-error-context ensures predictable parsing
        mypy_cmd = ["python", "-m", "mypy", ".", "--show-error-codes", "--no-error-summary", "--hide-error-context"]
        
        base_result = subprocess.run(mypy_cmd, cwd=base_dir, capture_output=True, text=True)
        post_result = subprocess.run(mypy_cmd, cwd=post_dir, capture_output=True, text=True)

        base_errors = parse_mypy_output(base_result.stdout, base_dir)
        post_errors = parse_mypy_output(post_result.stdout, post_dir)

        introduced_errors = []

        # 3. Analyze differences using Line-Mapping and Message Exhaustion
        for filepath, current_errors in post_errors.items():
            # Extract just the string messages from the baseline for this specific file
            baseline_msgs = [msg for line_num, msg in base_errors.get(filepath, [])]

            mod_lines = set()
            if filepath in modified_paths:
                mod_lines = get_modified_line_numbers(pre_state.get(filepath, ""), post_state[filepath])

            for line_num, msg in current_errors:
                # CONDITION A: The error falls directly on a line the LLM modified/inserted
                if filepath in modified_paths and line_num in mod_lines:
                    # Double check it wasn't a pre-existing error on that exact line (e.g. appended text)
                    if (line_num, msg) not in base_errors.get(filepath, []):
                        introduced_errors.append(f"Line {line_num} in {filepath}: {msg}")
                    continue

                # CONDITION B: The error is on an unmodified line, OR in a downstream file
                # We check if this exact error message existed in the baseline for this file.
                if msg in baseline_msgs:
                    # It's a legacy error. Remove it from the list to handle duplicates properly
                    # This safely ignores line-shifts caused by the LLM inserting code above it!
                    baseline_msgs.remove(msg) 
                else:
                    # It was NOT in the baseline. The LLM broke a downstream dependency!
                    introduced_errors.append(f"Downstream break in {filepath}:{line_num}: {msg}")

        if introduced_errors:
            return False, "Validation Failed. Introduced Errors:\n" + "\n".join(introduced_errors)

        return True, ""

```


# Milestone 3.6.7 : The "Do No Harm" Patch (Suite 3-6-6 Fixes)

### The Autopsy of the Regressions

**1. The "Catastrophic Wipe" Loophole (Tests 5, 11, 13, 14, 19)**
In our previous iteration, we implemented a "Node Integrity Shield" for protected methods (`__init__`, `clean`, `save`) that allowed a volume reduction *if* the new code contained a `super()` call.
**The Hack:** The 14B model learned this loophole! When it got confused about how to extract the `merge` logic or order number generation, it simply wrote a new method containing *only* `super().save(*args, **kwargs)` or `pass`, entirely deleting the core business logic. Because `super()` was present, our Python engine let it bypass the volume check.

**2. LibCST Indentation Crashes (Test 12)**
LibCST parses code as a full module before it grafts it into the target tree.  The 14B model frequently outputs its proposed replacement code with a 4-space indentation (because it knows the method belongs inside a class). When we pass an indented string directly to `cst.parse_module()`, LibCST immediately throws a fatal `Syntax Error: expected INDENT` or `unexpected INDENT`, causing the task to abort.

**3. The `_meta` Annihilation (Test 3)**
The prompt asked to "clean up" the manual `_meta` annotation. Because the 14B model lacked a targeted way to edit the inner attributes of a class without rewriting the whole thing, it just opted to delete the entire `_meta` class, breaking Django's ORM compatibility.

---

# ENGINEERING BRIEF: The "Do No Harm" Patch (Suite 3-6-6 Fixes)

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Patching the Volume Shield Loophole and LibCST Dedenting

We must physically prevent the LLM from deleting business logic by removing the `super()` bypass, and we must normalize its whitespace before feeding it to LibCST. Please implement these three exact patches in `refactor2.py`.

### Phase 1: LibCST Whitespace Normalization

**Task:** We must perfectly dedent the LLM's proposed code before passing it to `cst.parse_module()`, and let our `ModifyNodeTransformer` handle the re-indentation natively during the graft.
Update the `modify_node` execution block (where you instantiate the transformer):

```python
import textwrap
import libcst as cst

# Inside apply_actions_to_state for 'modify_node':
        elif action.action == "modify_node":
            content = new_state.get(path, "")
            try:
                # FIX: Strip leading/trailing blank lines and force dedent to 0-level indentation
                # This prevents LibCST from choking on LLM-generated indented blocks
                raw_llm_code = action.proposed_replace_string.strip('\n')
                normalized_new_code = textwrap.dedent(raw_llm_code)
                
                source_tree = cst.parse_module(content)
                transformer = ModifyNodeTransformer(
                    target_node_name=action.target_node_signature,
                    new_node_code=normalized_new_code
                )
                modified_tree = source_tree.visit(transformer)
                new_state[path] = modified_tree.code
                print(f"   🔄 [LibCST] Modified {action.target_node_signature}")
            except Exception as e:
                raise ValueError(f"LibCST modification failed for '{action.target_node_signature}': {e}")

```

### Phase 2: The Unbypassable "No-Wipe" Shield

**Task:** Remove the `super()` loophole. If the LLM proposes shrinking a method by more than 40% (unless the user explicitly asked to delete it), we mathematically reject the patch. Period.

Replace the current "Protected core methods shield" and "AST Volume Conservation Guardrail" with this unified, ruthless check:

```python
        # PHASE 2: The Ruthless No-Wipe Shield
        orig_len = len(original_node_text.strip())
        new_len = len(action.proposed_replace_string.strip())
        
        # If the node is substantial (over 100 chars), prohibit shrinking it by more than 40%
        if orig_len > 100 and new_len < (orig_len * 0.6):
            allowed_intents = ["remove", "delete", "drop", "clean up"]
            is_intent_deletion = any(word in intent.lower() for word in allowed_intents)
            
            # Explicitly block placeholders that the LLM uses to wipe logic
            has_dummy_logic = "pass" in action.proposed_replace_string or "NotImplementedError" in action.proposed_replace_string
            
            if not is_intent_deletion or has_dummy_logic:
                raise ValueError(
                    f"Safety Block: You attempted to replace '{action.target_node_signature}' ({orig_len} chars) "
                    f"with a significantly smaller implementation ({new_len} chars). "
                    f"This indicates a catastrophic wipe of business logic. You MUST preserve the existing functional logic."
                )

```

### Phase 3: The "Do No Harm" Task Abort

**Task:** In Test 14 and 19, the tool failed to insert the new utility methods, but it *did* successfully update the callers to use those missing methods, breaking the app.

We must enforce that if a `CreateFile` or `InsertNode` task fails and aborts, we do not blindly continue applying `ModifyNode` updates that depend on them.

In your main orchestration loop, add a dependency check:

```python
    # In the main task loop:
    failed_critical_tasks = False
    
    for i, task in enumerate(task_list):
        if failed_critical_tasks and task.action_type in ["modify_node", "update_docstring"]:
            print(f"⚠️ Skipping Task {i+1} to prevent downstream breakage from earlier failures.")
            continue
            
        # ... retry loop logic ...
        
        if not success:
            print(f"❌ Task {i+1} failed after {max_retries} attempts.")
            # If we fail to create the necessary nodes, flag it so we don't break callers
            if task.action_type in ["create_file", "insert_node"]:
                failed_critical_tasks = True
            continue 

```


# Milestone 3.6.8 : The "Definitive Stability" Master Patch (Suite 3.6.7 Fixes)

# ENGINEERING BRIEF: The "Definitive Stability" Master Patch (Suite 3.6.7 Fixes)

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Curing LibCST Crashes, Dangling Callers, Context Wandering, and Context Overload

Please implement these five precise upgrades across `refactor2.py` and your MCP Context tool.

### Phase 1: The LibCST "Dummy Wrapper" Hack (Fixes Tests 12, 14, 18, 19)

**The Problem:** `LibCST` throws a fatal `Syntax Error: expected INDENT` if the LLM's proposed method has slightly misaligned whitespace relative to a global module.
**The Fix:** Wrap the LLM's raw string inside a dummy class before parsing it. This guarantees Python's strict block indentation rules are satisfied, allowing us to safely extract the AST node and graft it.

**Update `InsertNode` logic in `apply_actions_to_state`:**

```python
        elif action.action == "insert_node":
            content = new_state.get(path, "")
            try:
                # 1. Force the LLM's code into a valid, dedented string
                raw_llm_code = textwrap.dedent(action.new_node_code.strip('\n'))
                
                # 2. Wrap it in a dummy class to guarantee valid CST parsing for methods
                dummy_wrapper = f"class __DummyWrapper__:\n{textwrap.indent(raw_llm_code, '    ')}"
                dummy_tree = cst.parse_module(dummy_wrapper)
                
                # 3. Extract the clean node from the dummy class
                new_method_node = dummy_tree.body[0].body.body[0]
                
                if getattr(action, 'target_class_signature', None):
                    class InsertGraftTransformer(cst.CSTTransformer):
                        def leave_ClassDef(self, original_node, updated_node):
                            if original_node.name.value == action.target_class_signature:
                                new_body = list(updated_node.body.body) + [new_method_node]
                                return updated_node.with_changes(body=updated_node.body.with_changes(body=new_body))
                            return updated_node

                    source_tree = cst.parse_module(content)
                    modified_tree = source_tree.visit(InsertGraftTransformer())
                    new_state[path] = modified_tree.code
                    print(f"   ➕ [LibCST] Safely inserted method into {action.target_class_signature}")
                    continue
                    
                # Fallback for global functions
                new_state[path] = content.rstrip() + "\n\n" + raw_llm_code + "\n"
                
            except Exception as e:
                raise ValueError(f"LibCST parsing failed for new node: {e}")

```

### Phase 2: Two-Phase Commit for Caller Safety (Fixes Tests 11, 13, 16)

**The Problem:** The engine fails to insert a new utility method, but still updates the caller to use that non-existent method, breaking the application.
**The Fix:** Implement a strict Dependency Registry. If an `InsertNode` task fails, globally block any subsequent `ModifyNode` task that might depend on it.

**Update the Orchestration Loop in `refactor2.py`:**

```python
    # Before the task loop starts, initialize the failure shield
    failed_critical_tasks = False

    for i, task in enumerate(task_list):
        # Prevent Dangling Callers:
        if failed_critical_tasks and task.action_type in ["modify_node", "update_docstring"]:
            print(f"⚠️ Skipping Task {i+1} to prevent breaking callers (a previous insertion/creation failed).")
            continue
            
        # ... execute retry loop ...
        
        if not success:
            print(f"❌ Task {i+1} failed.")
            if task.action_type in ["insert_node", "create_file"]:
                # Trigger the global shield to protect downstream callers
                failed_critical_tasks = True

```

### Phase 3: Curing Context Wandering (Pydantic & Sys Prompt)

**The Problem:** When asked to audit a specific file, the model wanders off and updates docstrings in unrelated RAG context files.
**The Fix:** Force the LLM to declare its primary targets and restrict modifications to them.

**1. Update the Pydantic Schema:**

```python
class RefactoringPlan(BaseModel):
    primary_target_files: List[str] = Field(
        ..., 
        description="The exact file path(s) you are explicitly asked to audit or refactor. Do NOT include RAG context files here."
    )
    tasks: List[Union[CreateFile, ModifyNode, InsertNode, UpdateDocstring, AddImport]]

```

**2. Update the System Prompt:**

```python
    "5. NO CONTEXT WANDERING: You will be provided with context files to help you understand the codebase. Do NOT modify these context files unless explicitly required to update a caller. If asked to audit a specific file, restrict 100% of your docstring/formatting updates to that specific file."

```

### Phase 4: Explicit Import Scrubbing (Fixes Tests 1, 6)

**The Problem:** `MoveNode` leaves duplicate/broken imports behind.
**The Fix:** Use aggressive regex in the downstream resolver.

**Update the `MoveNode` downstream resolver logic:**

```python
        # Inside apply_actions_to_state for move_node:
        old_module_path = path_to_python_module(source_path)
        new_module_path = path_to_python_module(target_path)
        node_name = extract_name_from_signature(action.node_signature)

        for file_path in affected_files:
            content = new_state.get(file_path, master_state.get(file_path, ""))
            if content:
                # 1. Strip the exact old import line
                exact_old_import = f"from {old_module_path} import {node_name}"
                content = content.replace(exact_old_import, "")
                
                # 2. Handle comma-separated imports (e.g., from X import A, Node, B)
                comma_pattern = re.compile(rf"^(from\s+{re.escape(old_module_path)}\s+import\s+.*?\b){node_name}\b,?\s*(.*)$", re.MULTILINE)
                content = comma_pattern.sub(r"\1\2", content)
                
                # 3. Prepend the new import
                new_import = f"from {new_module_path} import {node_name}\n"
                new_state[file_path] = new_import + content.lstrip()

```

### Phase 5: Dynamic Context Truncation (The MCP Layer)

**The Problem:** The 14B model is overwhelmed by the sheer token volume of related RAG files, triggering context amnesia.
**The Fix:** If the user prompt contains "audit", "standardize", or "comprehensive", we strip the business logic out of all secondary context files, providing the LLM with only the structural "skeleton" (class names, method signatures, and imports) so it knows *how* to call the files without getting distracted by *what* they do.

**Update `get_hybrid_context` (and add the `ast` helper function):**

```python
import ast

def get_file_skeleton(source_code: str) -> str:
    """Strips out implementation logic, returning only imports, classes, and method signatures."""
    try:
        tree = ast.parse(source_code)
        skeleton = []
        for node in tree.body:
            if isinstance(node, (ast.Import, ast.ImportFrom)):
                skeleton.append(ast.unparse(node))
            elif isinstance(node, ast.ClassDef):
                skeleton.append(f"class {node.name}:")
                for item in node.body:
                    if isinstance(item, ast.FunctionDef):
                        skeleton.append(f"    def {item.name}(...): pass")
                    elif isinstance(item, ast.AsyncFunctionDef):
                        skeleton.append(f"    async def {item.name}(...): pass")
            elif isinstance(node, ast.FunctionDef):
                skeleton.append(f"def {node.name}(...): pass")
        return "\n".join(skeleton)
    except SyntaxError:
        return source_code[:500] + "\n... [Content Truncated due to SyntaxError] ..."

def get_hybrid_context(target_files: List[str], context_files: List[str], user_prompt: str) -> str:
    """Builds the XML context for the LLM prompt, truncating secondary files during audits."""
    
    # Check if we should activate strict focus mode
    audit_keywords = ["audit", "standardize", "comprehensive", "clean up"]
    is_audit_mode = any(word in user_prompt.lower() for word in audit_keywords)
    
    context_xml = ""
    
    # 1. Provide FULL content for the explicitly targeted files
    for target in target_files:
        content = fetch_file_content(target) # Assume this is your existing fetch function
        context_xml += f"<target_file path='{target}'>\n{content}\n</target_file>\n"
        
    # 2. Truncate secondary context files if in audit mode
    for ctx_file in context_files:
        if ctx_file in target_files:
            continue
            
        content = fetch_file_content(ctx_file)
        
        if is_audit_mode:
            skeleton = get_file_skeleton(content)
            context_xml += f"<context_file path='{ctx_file}' note='TRUNCATED SKELETON FOR REFERENCE'>\n{skeleton}\n</context_file>\n"
        else:
            context_xml += f"<context_file path='{ctx_file}'>\n{content}\n</context_file>\n"
            
    return context_xml

```

# Milestone 3.6.9 :  The DeepSeek Transition & State Machine Hardening

# ENGINEERING BRIEF: The DeepSeek Transition & State Machine Hardening

**To:** Lead/Senior AI Engineer

**From:** Principal AI Architect

**Subject:** MoE Context Expansion, False Success Shield, and CreateFile Hard Gate

**Context:** We are migrating our local backend to `deepseek-coder-v2` (MoE) to resolve severe logic hallucinations and path errors. To fully support this model and patch the remaining execution loopholes in `refactor2.py`, please implement the following three critical updates.

---

### PART 1.2: Expanding the DeepSeek Context Window

**The Problem:** By default, Ollama heavily restricts the context window (usually to 2048 or 4096 tokens) to conserve RAM. If we pipe our massive GraphRAG XML context into this default window, it will silently truncate, blinding the model to the target files.
**The Fix:** We must explicitly allocate a 32k context window in the API call. DeepSeek V2 Lite is highly optimized and can handle this on a 24GB Unified Memory architecture.

**Implementation:** Locate your LLM completion call in `refactor2.py` (whether you are using LiteLLM or the standard `openai` Python client targeting `localhost:11434`) and inject the `num_ctx` option.

```python
# Update your LLM completion function (e.g., inside the planner or self-healing loop):
response = client.chat.completions.create(
    model="deepseek-coder-v2", # Make sure this matches your Ollama tag
    messages=messages,
    temperature=0.1, # Keep it deterministic
    # If using OpenAI client format for Ollama, pass extra_body:
    extra_body={
        "options": {
            "num_ctx": 32768  # 32k context window for heavy GraphRAG
        }
    }
)

```

*(Note: If you are using LiteLLM, you can pass this via `custom_llm_provider="ollama"` and `num_ctx=32768` as a direct kwargs parameter).*

---

### PART 2: Eradicating the "False Success" Bug

**The Problem:** In recent tests, LibCST successfully parsed the code without crashing, but because the LLM hallucinated a target node signature, the transformer didn't actually match any nodes. It returned the AST entirely unchanged. Because no exceptions were thrown, `refactor2.py` blindly marked the task as "Success", completely lying to the planner and breaking downstream dependencies.

**The Fix:** We must mathematically verify that a mutation occurred. We will snapshot the pre-execution string and compare it to the post-execution string.

**Implementation:** Update `apply_actions_to_state` in `refactor2.py`. Apply this check to `modify_node`, `update_docstring`, and `delete_lines`.

```python
        elif action.action == "modify_node":
            content = new_state.get(path, "")
            original_content = content  # SNAPSHOT THE STATE
            
            try:
                raw_llm_code = action.proposed_replace_string.strip('\n')
                normalized_new_code = textwrap.dedent(raw_llm_code)
                
                source_tree = cst.parse_module(content)
                transformer = ModifyNodeTransformer(
                    target_node_name=action.target_node_signature,
                    new_node_code=normalized_new_code
                )
                modified_tree = source_tree.visit(transformer)
                new_state[path] = modified_tree.code
                
                # THE FALSE SUCCESS SHIELD
                if new_state[path] == original_content:
                    raise ValueError(
                        f"False Success: No changes were made to the file. "
                        f"The target node '{action.target_node_signature}' was not found in the AST. "
                        f"Ensure you are using the EXACT class or method name as it appears in the file."
                    )
                    
                print(f"   🔄 [LibCST] Modified {action.target_node_signature}")
            except Exception as e:
                raise ValueError(f"LibCST modification failed: {e}")

```

---

### PART 3: The `CreateFile` Abuse Shield

**The Problem:** When the 14B model panicked or hit a wall during self-healing, it bypassed the strict AST rules of `modify_node` by simply calling `create_file` to completely overwrite an existing file (like `loading.py`). This caused catastrophic logic wipes.
**The Fix:** A hard gate at the execution router. If the target path exists in the repository state, `create_file` must immediately abort.

**Implementation:** Update the `create_file` block in `apply_actions_to_state`.

```python
        elif action.action == "create_file":
            # THE ABUSE SHIELD
            if path in master_state or path in new_state:
                raise ValueError(
                    f"Action Rejected: You attempted to use 'create_file' on '{path}', "
                    f"but this file ALREADY EXISTS in the repository. "
                    f"You MUST use 'modify_node', 'insert_node', or 'update_docstring' to edit existing files."
                )
                
            new_state[path] = action.content
            print(f"   📄 Created new file {path}")

```

# Milestone 3.6.10 : The MoE Constraint Patch (Suite 3-6-9 Fixes)

Background on why tests in refactor-test-report-3-6-9.md failed.
Here is the architectural teardown of the MoE friction points and the precise engineering brief to patch refactor2.py in RepoOS2.

1. The DeepSeek Friction Points
Friction A: The "Architectural Hallucination" Loop (Tests 2, 5, 7, 10, 19)
DeepSeek is over-engineering. Asked to extract a simple BOM handler, it tries to create a whole new oscar/core/config directory. Asked to add type hints, it tries to create a new typing_utils.py file.
The Fix: We must violently constrain the planner. The prompt must explicitly forbid the creation of new files unless the user's prompt explicitly commands it.

Friction B: The CreateFile / ModifyNode Cognitive Dissonance (Tests 14, 20)
DeepSeek frequently outputs a plan to CreateFile for utils.py, gets blocked by our new Abuse Shield (because utils.py already exists), and then panics during the self-heal.
The Fix: Instead of throwing a fatal ValueError when create_file hits an existing path, we should dynamically intercept the action in the engine and convert it into a modify_node or insert_node warning, letting the self-heal loop know it picked the wrong tool without aborting the plan.

Friction C: The Context Resolution Bug (Tests 1, 6)
DeepSeek generated paths like oscar/core/models/oscar/apps/catalogue/.... Why? Because when we feed it the GraphRAG XML, we provide paths relative to the project root, but DeepSeek is confusing them with Django app labels.
The Fix: We need to enforce strict path prefixing in the Pydantic schema validation.

# ENGINEERING BRIEF: The MoE Generic Constraint Patch (Suite 3-6-9 Fixes)

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Taming DeepSeek: Generic Path Resolution and Architectural Constraints
**Context:** The MoE model is over-engineering and hallucinating paths. We must constrain its behavior and auto-resolve path truncations generically so RepoOS works on *any* target codebase, without hardcoded folder names.

Please implement these three exact upgrades into `refactor2.py`.

### Phase 1: Dynamic Tool Redirection (Soft-Reject `create_file`)

**Task:** Stop aborting the task when DeepSeek tries to `create_file` on an existing file. Let the engine softly reject it and instruct the LLM on which tool to use.

**Implementation in `apply_actions_to_state`:**

```python
        if action.action == "create_file":
            if path in master_state or path in new_state:
                # SOFT REJECT: Tell the self-heal loop exactly how to fix its mistake generically
                raise ValueError(
                    f"Tool Selection Error: You attempted to use 'create_file' on '{path}', "
                    f"but this file ALREADY EXISTS in the repository. "
                    f"To add new functions to this file, you MUST use the 'insert_node' tool. "
                    f"To change existing functions, use 'modify_node'."
                )
                
            new_state[path] = action.content

```

### Phase 2: Generic Path Auto-Resolution & Validation

**Task:** Prevent DeepSeek from using placeholders, and gracefully auto-correct paths if the LLM drops the project's root directory name.

**1. Update Pydantic Schemas to block structural placeholders (Project-Agnostic):**

```python
from pydantic import BaseModel, Field, field_validator

class RefactorActionBase(BaseModel):
    file_path: str = Field(..., description="The exact repository path to the file.")

    @field_validator('file_path')
    def validate_strict_path(cls, v):
        # Block generic placeholders and angle brackets
        forbidden = ["<", ">", "path/to", "your_project", "...", "dummy"]
        if any(f in v.lower() for f in forbidden):
            raise ValueError(f"Invalid placeholder path detected: {v}. You MUST use the exact paths from the context.")
            
        # Block absolute paths and parent traversal
        if v.startswith("/") or "../" in v:
            raise ValueError(f"Paths must be strictly relative to the project root. Do not use '/' or '../'. Received: {v}")
            
        return v

```

**2. Add Generic Auto-Resolution in `apply_actions_to_state`:**
Inject this right after you extract `path = action.file_path`, *before* executing the tool logic. This allows the engine to adapt to any project structure dynamically.

```python
        path = action.file_path
        
        # GENERIC PATH AUTO-RESOLUTION
        # If the exact path is missing, check if the LLM truncated the project root directory
        if path not in master_state and action.action != "create_file":
            # Find any file in the graph that ends with the LLM's provided path
            possible_matches = [p for p in master_state.keys() if p.endswith("/" + path) or p == path]
            
            if len(possible_matches) == 1:
                print(f"   🔍 Auto-corrected truncated path: '{path}' -> '{possible_matches[0]}'")
                path = possible_matches[0]
            elif len(possible_matches) > 1:
                raise ValueError(f"Ambiguous path '{path}'. It matches multiple files: {possible_matches}. Please provide the full path.")
            else:
                raise ValueError(f"File '{path}' does not exist in the repository context.")

```

### Phase 3: The "Anti-Overengineering" System Prompt

**Task:** DeepSeek is highly responsive to system prompts. We must explicitly forbid it from creating architectural patterns (like new `utils.py` files) unless requested. Ensure the prompt applies to *any* language/framework.

**Update the `sys_prompt` for the Planner and the Action Generator:**

```python
sys_prompt = (
    "You are an elite Principal AI Engineer refactoring a complex codebase. "
    "CRITICAL ARCHITECTURAL RULES: \n"
    "1. NO OVER-ENGINEERING: Do NOT create new utility files, configuration files, or helper modules unless the user's prompt explicitly commands you to do so. If asked to add type hints, docstrings, or extract logic, modify the existing files ONLY.\n"
    "2. TOOL SELECTION: If you need to add a new function or class to an existing file, you MUST use 'insert_node'. Do NOT use 'create_file' on a file that already exists in the provided context.\n"
    "3. PATH ACCURACY: Never invent paths. ALL file paths must exactly match the `<target_file path='...'>` or `<context_file path='...'>` attributes provided to you.\n"
    "4. NO DUMMY LOGIC: When extracting or modifying code, preserve the EXACT original business logic. Never use placeholders like `pass`.\n"
)

```

# Milestone 3.6.11 : 

Phase 1: Syncing the Planner's Brain
Task: We must restrict the Planner so it mathematically cannot propose over-engineered files (like type_hints.py) before the execution loop even begins.

Update task_sys_prompt (around line 431 in refactor2.py):

Python
        task_sys_prompt = (
            "You are a senior architect. Generate a sequential list of refactoring tasks.\n"
            "CRITICAL ARCHITECTURAL RULES: \n"
            "1. NO OVER-ENGINEERING: Do NOT create new utility files, configuration files, or helper modules unless explicitly commanded. If asked to add type hints, docstrings, or extract logic, you MUST modify the existing files ONLY.\n"
            "2. PRIMARY TARGETS: You MUST identify the 'primary_target_files'. These are the files you are explicitly asked to refactor or audit.\n"
            "3. NEW FILES: If the instruction requires creating a new file, your VERY FIRST task MUST be to create that file.\n"
            "4. PATH ACCURACY: Never invent paths. ALL file paths must exactly match the provided context. Do not use placeholders like 'project_root/' or 'your_project/'."
        )
Phase 2: Aggressive Root Stripping
Task: We must catch literal root hallucinations (project_root/) and violently strip them out before passing the path to our dynamic resolver.

Update resolve_dynamic_path (around line 223 in refactor2.py):

Python
def resolve_dynamic_path(raw_path: str, master_state: dict, is_new_file: bool = False) -> str:
    """Generically resolves truncated LLM paths for both existing and new files."""
    if not raw_path:
        return raw_path
        
    # STRIP HALLUCINATED ROOTS: DeepSeek often takes "project root" literally
    raw_path = re.sub(r'^(project_root/|repo_root/|your_project/|dummy/)', '', raw_path, flags=re.IGNORECASE)
    
    if raw_path in master_state:
        return raw_path
        
    # 1. Match existing files (modify, delete, insert)
    # ... (Keep the rest of your existing logic here) ...
Phase 3: Pydantic Path Hardening
Task: Update both of your Pydantic path validators to instantly reject these literal root strings if they slip through the planner.

Update validate_no_placeholder_paths (around line 144) and validate_strict_path (around line 161) to include the new forbidden strings:

Python
        # In both validator functions, update the forbidden list:
        forbidden = ["<", ">", "path/to", "your_project", "...", "dummy", "project_root", "repo_root", "project-root"]


# Milestone 3.6.12

Tests are in refactor-test-report-3-6-10.md (Test run #3)
**1. The Pydantic Union Confusion (Test 1)**
*Error:* `15 validation errors... (actions.0.CreateFile.action: Input should be 'create_file' [type=literal_error, input_value='update_docstring'])`
*Why:* Pydantic V2 gets deeply confused when an LLM hallucinates mixed fields inside a `Union`. DeepSeek tried to output a `CreateFile` action, but accidentally named the action `update_docstring`. Pydantic didn't know which schema to validate against, so it threw 15 parallel errors, completely overwhelming the self-healing loop.
*The Fix:* We must use `Annotated` and a Pydantic `discriminator`. This forces Pydantic to look *only* at the `"action"` key to determine which schema to use, reducing 15 errors down to 1 clean error that the LLM can easily fix.

**2. The Planner's Ignorance of Macro-Actions (Test 1)**
*Error:* The Planner generated 4 tasks to manually create a file, move a class, and update imports.
*Why:* We built a brilliant, automated `MoveNode` macro-action in Python that handles all of this automatically! But *we never told the Planner it exists*. Because the Planner broke the job into manual steps, DeepSeek panicked during execution and tried to manually wrap the class instead of using our tool.

**3. The `ModifyNode` Indentation Crash (Test 2)**
*Error:* `LibCST parsing failed for new node: Syntax Error @ 24:1... expected INDENT`.
*Why:* We added the "Dummy Wrapper" hack to `InsertNode` to fix LibCST's indentation parsing, but we forgot to apply that exact same hack to `ModifyNodeTransformer`. When DeepSeek tried to modify `get_classes` with a decorator or specific whitespace, LibCST choked.

---

# ENGINEERING BRIEF: The DeepSeek Harmonization Patch

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Pydantic Discriminators, Planner Tool Awareness, and `ModifyNode` Wrapping

Please implement these three precise upgrades into `refactor2.py`.

### Phase 1: Pydantic Discriminators & XML Tag Stripping

**Task 1:** We must force Pydantic to cleanly route the JSON validation, and we must explicitly ban the `<target_file>` XML string from the paths.

**Update the imports and Unions in `refactor2.py` (around line 170):**

```python
from typing import List, Dict, Optional, Union, AsyncGenerator, Literal, Set, Tuple, Annotated

# --- Define the dynamic Unions ---
class RefactorProposalSafe(BaseModel):
    actions: List[Annotated[Union[CreateFile, ModifyNode, AddImport, MoveNode, InsertNode, UpdateDocstring, DeleteLines], Field(discriminator='action')]] = Field(..., description="A list of safe refactoring actions.")

class RefactorProposalUnsafe(BaseModel):
    actions: List[Annotated[Union[CreateFile, DeleteFile, ModifyNode, AddImport, MoveNode, InsertNode, UpdateDocstring, DeleteLines], Field(discriminator='action')]] = Field(..., description="A list of refactoring actions, including deletion.")

class RefactorProposal(BaseModel):
    actions: List[Annotated[Union[CreateFile, DeleteFile, ModifyNode, AddImport, MoveNode, InsertNode, UpdateDocstring, DeleteLines], Field(discriminator='action')]] = Field(..., description="A list of discrete refactoring actions.")

```

**Task 2:** Update `validate_no_placeholder_paths` (around line 105) to trap the XML tags:

```python
def validate_no_placeholder_paths(v: str) -> str:
    # Added XML tag patterns and more literal string bans
    forbidden = ["<", ">", "path/to", "your_project", "...", "dummy", "project_root", "repo_root", "project-root", "target_file path", "context_file path"]
    v_lower = v.lower()
    
    for sub in forbidden:
        if sub in v_lower:
            raise ValueError(f"Invalid path hallucination detected: '{v}'. You MUST output exact repository paths from the context.")

```

### Phase 2: Planner Macro-Action Awareness

**Task:** We must sync the Planner's brain with the Execution Engine's capabilities so it stops trying to manually orchestrate complex moves and type hints.

**Update `task_sys_prompt` (around line 450 in `refactor2.py`):**

```python
        task_sys_prompt = (
            "You are a senior architect. Generate a sequential list of refactoring tasks.\n"
            "CRITICAL ARCHITECTURAL RULES: \n"
            "1. NO OVER-ENGINEERING: Do NOT create new utility files or helper modules unless explicitly commanded.\n"
            "2. TYPE HINTS & DOCSTRINGS: NEVER create a new file for type hints (e.g. `type_hints.py`). Type hints and docstrings MUST be added inline to the existing files.\n"
            "3. MACRO-ACTIONS: The execution engine has a powerful 'move_node' tool that automatically creates the target file, moves the code, and updates all downstream imports. If asked to move a class/function, output a SINGLE task instructing the executor to 'Use move_node'.\n"
            "4. PRIMARY TARGETS: You MUST identify the 'primary_target_files'.\n"
            "5. PATH ACCURACY: Never invent paths. ALL file paths must exactly match the provided context."
        )

```

### Phase 3: The `ModifyNode` Dummy Wrapper

**Task:** Apply the exact same LibCST indentation hack from `InsertNode` to `ModifyNodeTransformer` so LibCST stops crashing on valid DeepSeek code.

**Update `ModifyNodeTransformer.__init__` (around line 24 in `refactor2.py`):**

```python
class ModifyNodeTransformer(cst.CSTTransformer):
    """Replaces a function/method while mathematically guaranteeing decorator preservation."""
    def __init__(self, target_node_name: str, new_node_code: str):
        self.target_node_name = target_node_name.split('.')[-1]
        
        # Ensure no leading whitespace on the very first line breaks the dummy wrapper
        clean_code = new_node_code.lstrip()
        
        # APPLY THE DUMMY WRAPPER HACK
        dummy_wrapper = f"class __DummyWrapper__:\n{textwrap.indent(clean_code, '    ')}"
        parsed_module = cst.parse_module(dummy_wrapper)
        
        # Extract the actual node from inside the dummy class
        self.new_node_ast = parsed_module.body[0].body.body[0]

```

# Milestone 3.6.13

Phase 1: Making MoveNode Auto-Initialize Files (Fixes Test 1)
The Bug: DeepSeek used move_node to move the class to oscar/core/csv_utils.py. The execution engine crashed with File ... not found in state because it tried to append the AST node to a file that didn't exist in the new_state dictionary.
The Fix: We must manually initialize an empty string for the target file in the execution state before we try to graft the node into it.

Update the move_node block inside apply_actions_to_state in refactor2.py:

Python
        elif action.action == "move_node":
            source_path = action.source_file
            target_path = action.target_file
            
            # --- THE AUTO-INITIALIZATION PATCH ---
            # If the target file doesn't exist yet, create it in the state so LibCST has a canvas
            if target_path not in new_state and target_path not in master_state:
                new_state[target_path] = ""
                print(f"   📄 Auto-created target file for MoveNode: {target_path}")
            # -------------------------------------

            content_source = new_state.get(source_path, "")
            content_target = new_state.get(target_path, master_state.get(target_path, ""))
            
            try:
                # ... (Keep your existing LibCST extraction and insertion logic here) ...
Phase 2: Bulletproof Prefix Stripping (Fixes oscarmain/)
The Bug: DeepSeek hallucinated the prefix oscarmain/. Our regex only looked for project_root/ or repo_root/.
The Fix: Instead of playing whack-a-mole with hallucinated repo names, we will use a regex that violently strips any arbitrary directory that precedes the known src/ or oscar/ base directories.

Update resolve_dynamic_path in refactor2.py:

Python
def resolve_dynamic_path(raw_path: str, master_state: dict, is_new_file: bool = False) -> str:
    """Generically resolves hallucinated or truncated LLM paths for ANY project structure."""
    if not raw_path:
        return raw_path
        
    # 1. Strip explicit literal placeholders (these are universally bad LLM habits)
    raw_path = re.sub(r'^(project_root/|repo_root/|your_project/|dummy/|<target_file path=)', '', raw_path, flags=re.IGNORECASE)
    raw_path = raw_path.strip("'>\"") # Clean up trailing XML/quote artifacts
    
    if raw_path in master_state:
        return raw_path
        
    # 2. PROGRESSIVE SUFFIX MATCHING (For existing files)
    # If the LLM prepends garbage (e.g. 'oscarmain/src/api.py' instead of 'my_repo/src/api.py'),
    # we iteratively drop the leftmost directory until we lock onto a unique real path.
    parts = raw_path.split('/')
    for i in range(len(parts)):
        test_suffix = "/".join(parts[i:])
        possible_matches = [p for p in master_state.keys() if p.endswith("/" + test_suffix) or p == test_suffix]
        
        if len(possible_matches) == 1:
            print(f"   🔍 Auto-corrected existing path: '{raw_path}' -> '{possible_matches[0]}'")
            return possible_matches[0]
        # If len > 1, it's ambiguous (e.g., dropping until just 'utils.py' remains). We continue to fail safely.

    # 3. DIRECTORY-AWARE MATCHING (For new files like MoveNode targets)
    # If the file doesn't exist yet, we apply the progressive matching to its parent directory
    if is_new_file or not possible_matches:
        parent_dir = os.path.dirname(raw_path)
        filename = os.path.basename(raw_path)
        
        if parent_dir:
            parent_parts = parent_dir.split('/')
            for i in range(len(parent_parts)):
                test_parent_suffix = "/".join(parent_parts[i:])
                for existing_path in master_state.keys():
                    if f"/{test_parent_suffix}/" in existing_path or existing_path.startswith(f"{test_parent_suffix}/"):
                        # Extract the true project root prefix from the existing sibling file
                        prefix = existing_path.split(test_parent_suffix)[0]
                        resolved = os.path.join(prefix, test_parent_suffix, filename).replace('\\', '/')
                        print(f"   🔍 Auto-corrected new file path: '{raw_path}' -> '{resolved}'")
                        return resolved
                        
    return raw_path # Fallback to original if no match found
Phase 3: Forcing the Discriminator Key (Fixes Test 2)
The Bug: DeepSeek output {"file_path": "...", "target_node_signature": "...", "proposed_replace_string": "..."}, but forgot "action": "modify_node". Pydantic panicked.
The Fix: We must explicitly scream at the Execution LLM (the Action Generator) to include this mandatory literal key in every single JSON dictionary it generates.

Update the sys_prompt for the Action Generator (around line 350 in refactor2.py):

Python
sys_prompt = (
    "You are an elite Principal AI Engineer refactoring a complex codebase. "
    "CRITICAL ARCHITECTURAL RULES: \n"
    "1. MANDATORY ACTION KEY: You are generating a JSON list of actions. EVERY single action object MUST contain the exact 'action' key so the validator knows which schema to use. (e.g., `\"action\": \"modify_node\"` or `\"action\": \"insert_node\"`). If you omit this key, the system will crash.\n"
    "2. NO OVER-ENGINEERING: Modify the existing files ONLY unless commanded to create a new one.\n"
    "3. TOOL SELECTION: Use 'modify_node' to add type hints or change existing functions. Use 'insert_node' to add BRAND NEW functions.\n"
    "4. PATH ACCURACY: Never invent paths. ALL file paths must exactly match the provided context.\n"
    "5. NO DUMMY LOGIC: Preserve the EXACT original business logic. Never use placeholders like `pass`."
)

# Milestone 3.6.14

# ENGINEERING BRIEF: The Final Prompt Alignment

**To:** Lead/Senior AI Engineer
**From:** Principal AI Architect
**Subject:** Aligning Planner Strategy and Pydantic Compliance

Please replace the two system prompt blocks in `refactor2.py` with these updated versions.

### Phase 1: Syncing the Planner's Brain (Fixes Test 1)

**Task:** Replace the existing `task_sys_prompt` (around line 368 in `refactor2.py`) to inform the Planner about the `move_node` macro-action and forbid manual file creation for moves.

```python
        task_sys_prompt = (
            "You are a senior architect. Generate a sequential list of refactoring tasks.\n"
            "CRITICAL ARCHITECTURAL RULES: \n"
            "1. NO OVER-ENGINEERING: Do NOT create new utility files or helper modules unless explicitly commanded.\n"
            "2. TYPE HINTS & DOCSTRINGS: NEVER create a new file for type hints (e.g. `type_hints.py`). Type hints and docstrings MUST be added inline to the existing files.\n"
            "3. MACRO-ACTIONS: The execution engine has a powerful 'move_node' tool that automatically creates the target file, moves the code, and updates all downstream imports. If asked to move a class/function, output a SINGLE task instructing the executor to 'Use move_node'. Do NOT create the file manually first.\n"
            "4. PRIMARY TARGETS: You MUST identify the 'primary_target_files'.\n"
            "5. PATH ACCURACY: Never invent paths. ALL file paths must exactly match the provided context."
        )

```

### Phase 2: Forcing the Discriminator Key (Fixes Test 2)

**Task:** Replace the existing `sys_prompt` (around line 430 in `refactor2.py`) to inject the "MANDATORY ACTION KEY" instruction, forcing DeepSeek to comply with Pydantic's discriminator requirement.

```python
        sys_prompt = (
            "You are an elite Principal AI Engineer refactoring a complex codebase. "
            "CRITICAL ARCHITECTURAL RULES: \n"
            "1. MANDATORY ACTION KEY: You are generating a JSON list of actions. EVERY single action object MUST contain the exact 'action' key so the validator knows which schema to use (e.g., `\"action\": \"modify_node\"` or `\"action\": \"insert_node\"`). If you omit this key, the system will crash.\n"
            "2. NO OVER-ENGINEERING: Modify the existing files ONLY unless commanded to create a new one.\n"
            "3. TOOL SELECTION: \n"
            "- To add TYPE HINTS, docstrings, or change an existing function, you MUST use 'modify_node'.\n"
            "- To add a BRAND NEW function to an existing file, you MUST use 'insert_node'.\n"
            "- Do NOT use 'create_file' on a file that already exists.\n"
            "4. PATH ACCURACY: Never invent paths. ALL file paths must exactly match the `<target_file path='...'>` or `<context_file path='...'>` attributes provided to you.\n"
            "5. NO DUMMY LOGIC: When extracting or modifying code, preserve the EXACT original business logic. Never use placeholders like `pass`.\n"
            "6. EXTRACTION COMPLETENESS: If extracting logic, you MUST output the full extracted utility function, and you MUST update the original caller to use it.\n"
            "7. ABSOLUTE IMPORTS ONLY: Never use relative imports. ALL imports must be absolute paths from the project root.\n"
            "8. NO CODE OMISSION: Never use `# ...`, `// ...`, or `[rest of code]` placeholders. You MUST provide the COMPLETE and functional code for every node you output. Token laziness is strictly forbidden.\n"
        )

```

# Milestone 3.6.15 : The Final Lock-Down
### The Autopsy of the 8th Attempt
# ENGINEERING BRIEF: The Final Lock-Down

**To:** Lead/Senior AI Engineer

**From:** Principal AI Architect

**Subject:** Resolving AST Node Destruction and Path Ambiguity

Please apply these three precise patches to `refactor2.py`.

### Phase 1: The Ambiguity Tie-Breaker

**Task:** We must teach `resolve_dynamic_path` how to break ties when a path matches both a source file and a test file.

**Update the `resolve_dynamic_path` loop in `refactor2.py`:**

```python
    # 2. PROGRESSIVE SUFFIX MATCHING (For existing files)
    parts = raw_path.split('/')
    for i in range(len(parts)):
        test_suffix = "/".join(parts[i:])
        possible_matches = [p for p in master_state.keys() if p.endswith("/" + test_suffix) or p == test_suffix]
        
        if len(possible_matches) == 1:
            print(f"   🔍 Auto-corrected existing path: '{raw_path}' -> '{possible_matches[0]}'")
            return possible_matches[0]
        elif len(possible_matches) > 1:
            # THE TIE-BREAKER: Filter out 'tests/' directories unless explicitly asked for
            non_test_matches = [p for p in possible_matches if "/tests/" not in p and "test_" not in p.split('/')[-1]]
            if len(non_test_matches) == 1:
                print(f"   🔍 Auto-corrected ambiguous path (Tie-breaker won): '{raw_path}' -> '{non_test_matches[0]}'")
                return non_test_matches[0]
            
            # If still ambiguous, default to the shortest path (usually the core source file)
            best_match = min(possible_matches, key=len)
            print(f"   ⚠️ Ambiguous path '{raw_path}'. Defaulting to shortest: '{best_match}'")
            return best_match

```

### Phase 2: The `MoveNode` State Fallback

**Task:** We must ensure `MoveNode` reads from the `master_state` if the source file hasn't been edited yet.

**Update the variable assignment inside the `move_node` execution block:**

```python
        elif action.action == "move_node":
            source_path = action.source_file
            target_path = action.target_file
            
            if target_path not in new_state and target_path not in master_state:
                new_state[target_path] = ""
                print(f"   📄 Auto-created target file for MoveNode: {target_path}")

            # THE STATE FALLBACK PATCH: Must check master_state if not in new_state
            content_source = new_state.get(source_path, master_state.get(source_path, ""))
            content_target = new_state.get(target_path, master_state.get(target_path, ""))
            
            if not content_source:
                raise ValueError(f"Move Error: Source file {source_path} is empty or not found in state.")

```

### Phase 3: The "Anti-Destruction" Prompt Rules

**Task:** We must explicitly enforce the `add_import` tool so DeepSeek stops trying to overwrite functions with import strings.

**Update the `sys_prompt` Tool Selection rules (around line 430):**

```python
            "3. TOOL SELECTION: \n"
            "- To add IMPORTS, you MUST use the 'add_import' action. NEVER use 'modify_node' to add imports, as it will overwrite and destroy the target function.\n"
            "- To add TYPE HINTS, docstrings, or change an existing function, you MUST use 'modify_node'.\n"
            "- To add a BRAND NEW function to an existing file, you MUST use 'insert_node'.\n"
            "- Do NOT use 'create_file' on a file that already exists.\n"

```

**Task 2:** We must also stop the Planner from hallucinating module names like `oscarmodule`. Add this rule to the `task_sys_prompt`:

```python
            "5. EXACT CONTEXT: Do NOT hallucinate module names (like 'oscarmodule') in your context output. You MUST use the exact file paths provided to you."

```