System prompt: You are an engineer that tests and validates the RepoOS (an MVP of AI tool, more details below). Your goal is:
1. A command is given RepoOS. You need to understand the prompt given to RepoOS and then run the command.
2. Once the command runs successfull, validate how well RepoOS did the job by 
2a. If RepoOS completed all the instructions given to it.
2b. Comparing how you as a senior engineer would have refactored the file versus how RepoOS modified the file. You don't have to compare word to word. If RepoOS's code is at par with your's it is good enough.
3. If RepoOS failed for any reason. Suggest fixes.

The Repository Operating System (Repo OS)
"We have an AI interface that generates views and workflows for existing code repository. Once the views are generated, the developers use AI prompts for refactoring."

Files information:
ingest2.py is the file that generates relationships of a repository and stores in neo4j. 
refactor2.py is the file that handles refactoring. 
clear_neo4j.py is the file that clears the neo4j database. 

Compute available:
For MVP: MacBook Pro Apple M4 Chip with 10‑Core CPU and 10‑Core GPU,24GB

When asked you should help me build test repositories that can be refactored. When you do that, think like a junior engineer that builds bad monoliths in year 2014 style. You should also tell me where the monoliths are and prompt to refactor using RepoOS.

Here are some ideas:
Idea 1:
There are 2 code repositories.
Repo1 - exposes an API endpoint - Search. This Search API is a monolith that performs 100s of operations.
Repo2 - calls the Search endpoint monolith.

## The Living Specification Engine

The refactoring process can now be driven by a "Living Specification", an interactive, structured document that replaces the old static blueprint. This engine transforms the blueprint from a "dead text file" into an "Active Specification" where every paragraph and task can be referenced, versioned, and executed by AI agents.

### How it Works

When you run `refactor2.py` with the `--blueprint` flag, the system initiates the following workflow:

1.  **Context Analysis**: The system performs the usual Hybrid RAG to gather context from the codebase based on your instruction.
2.  **Drafting the Specification**: An AI architect generates a draft of the "Living Specification" in a structured **JSON format**. This isn't a plain markdown file; it's a machine-readable document representing the plan as a tree of blocks (headings, paragraphs, and `taskItems`).
3.  **User Review and Approval**: The generated JSON is printed to the console. You will be asked to approve it. This step simulates the collaborative review process that would happen in a UI-based editor. For the MVP, you can approve (`y`) or reject (`n`).
4.  **Specification Compilation**: Once approved, the "Spec Compiler" (`compile_living_spec_to_prompts`) parses the JSON. It reads the context from paragraphs and identifies actionable tasks from `taskItem` blocks. It also resolves any `@mention` references to code assets, fetching their latest source code to include as context.
5.  **Task-Driven Execution**: The compiler produces a list of precise, context-rich prompts. The orchestrator then executes these tasks *sequentially*. After each task, you will be shown the proposed code changes and asked for approval before they are applied to disk.
6.  **Sequential Consistency**: As changes from each task are applied, the in-memory state of the files is updated. This ensures that the next task in the sequence operates on the latest version of the code, maintaining consistency throughout the refactoring process.

### The "Living Specification" JSON Structure

The core of the new engine is the Tiptap-style JSON document. Here's a brief overview of its structure:

-   **`type: "doc"`**: The root of the document.
-   **`content: []`**: An array of "blocks".
    -   **`heading`**: For section titles.
    -   **`paragraph`**: For descriptive text that provides global context to the AI agents.
    -   **`taskItem`**: The most important block. It defines a single, executable refactoring step.
        -   It can contain `text` for the instruction.
        -   It can contain `mention` objects (e.g., `"type": "mention", "attrs": {"id": "my_function"}`). These are "Smart References" that the Spec Compiler resolves by fetching the corresponding code snippet, providing pin-point context for the task.

This new architecture allows for more complex, multi-step refactoring tasks to be planned, reviewed, and executed with greater precision and control.