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