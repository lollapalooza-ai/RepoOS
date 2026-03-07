import difflib
import argparse
import os
import sys
import json
import re
import asyncio
import ollama
import textwrap
import tree_sitter_python as tspython
from tree_sitter import Language, Parser
from neo4j import GraphDatabase
from sentence_transformers import SentenceTransformer
from pydantic import BaseModel, Field, field_validator
from typing import List, Dict, Optional, Union, AsyncGenerator, Literal, Set, Tuple
import hashlib
import ast
import pyflakes.api
import pyflakes.reporter
import io
import tempfile
import subprocess
import libcst as cst

# --- Config ---
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M"

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

class ModifyNodeTransformer(cst.CSTTransformer):
    """Replaces a function/method while mathematically guaranteeing decorator preservation."""
    def __init__(self, target_node_name: str, new_node_code: str):
        self.target_node_name = target_node_name.split('.')[-1] # Strip class prefix if present
        
        # Parse the LLM's proposed replacement logic
        parsed_module = cst.parse_module(new_node_code)
        self.new_node_ast = parsed_module.body[0]

    def leave_FunctionDef(self, original_node: cst.FunctionDef, updated_node: cst.FunctionDef) -> cst.CSTNode:
        if original_node.name.value == self.target_node_name:
            # Type safety check: Ensure the LLM didn't hallucinate a non-function node
            if isinstance(self.new_node_ast, (cst.FunctionDef, cst.ClassDef)):
                return self.new_node_ast.with_changes(decorators=original_node.decorators)
            return self.new_node_ast # Return as-is if the LLM changed the node type entirely
        return updated_node

    def leave_ClassDef(self, original_node: cst.ClassDef, updated_node: cst.ClassDef) -> cst.CSTNode:
        if original_node.name.value == self.target_node_name:
            # Same shield applies to Class decorators (e.g., @dataclass)
            if isinstance(self.new_node_ast, (cst.FunctionDef, cst.ClassDef)):
                return self.new_node_ast.with_changes(decorators=original_node.decorators)
            return self.new_node_ast
            
        return updated_node
VENV_PYTHON = sys.executable

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
            try:
                # Use os.path.join and then relpath to get a consistent relative path
                abs_path = os.path.abspath(os.path.join(base_dir, filepath))
                rel_path = os.path.relpath(abs_path, base_dir)
                if rel_path not in errors:
                    errors[rel_path] = []
                errors[rel_path].append((int(line_num), msg.strip()))
            except ValueError:
                continue
    return errors

def get_mypy_errors(filepath: str) -> set:
    """Runs mypy and returns a set of error strings, ignoring line numbers for baseline comparison."""
    result = subprocess.run(
        [VENV_PYTHON, "-m", "mypy", filepath, "--ignore-missing-imports", "--follow-imports=silent"],
        capture_output=True, text=True, check=False
    )
    # Strip line numbers so we can compare the exact error signatures
    errors = set()
    for line in result.stdout.splitlines():
        if "error:" in line:
            # Extract everything after "error:" to ignore line shifts
            # Format is usually: path/to/file.py:line: error: message
            parts = line.split("error:")
            if len(parts) > 1:
                errors.add(parts[1].strip())
    return errors

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
        # We use VENV_PYTHON to ensure we use the same environment
        mypy_cmd = [VENV_PYTHON, "-m", "mypy", ".", "--show-error-codes", "--no-error-summary", "--hide-error-context", "--ignore-missing-imports", "--follow-imports=silent"]
        
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
                mod_lines = get_modified_line_numbers(pre_state.get(filepath, ""), post_state.get(filepath, ""))

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

class ASTCollisionError(Exception):
    pass

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

def is_semantically_valid(content: str) -> tuple[bool, str]:
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
            return False, f"Code contains forbidden placeholder: '{phrase}'. Token laziness is strictly prohibited. You MUST write the COMPLETE and executable node."
    
    return True, ""


# --- Pydantic Validators (Phase 4: Anti-Hallucination) ---
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

# --- Pydantic Models (Step 2: Constrained Decoding) ---

class TaskItem(BaseModel):
    task: str = Field(..., description="A clear, actionable description of the refactoring step.")
    context: Dict[str, List[str]] = Field(..., description="A mapping of file paths to the specific functions or classes relevant to this task.")

class TaskList(BaseModel):
    primary_target_files: List[str] = Field(
        ..., 
        description="The exact file path(s) you are explicitly asked to audit or refactor. Do NOT include RAG context files here."
    )
    tasks: List[TaskItem] = Field(..., description="A sequential list of tasks to complete the refactor.")

class CreateFile(BaseModel):
    action: Literal["create_file"] = "create_file"
    file_path: str = Field(..., description="Path to the new file.")
    content: str = Field(..., description="The complete content of the new file.")
    
    @field_validator('file_path')
    @classmethod
    def check_path(cls, v): return validate_no_placeholder_paths(v)

class DeleteFile(BaseModel):
    action: Literal["delete_file"] = "delete_file"
    file_path: str = Field(..., description="Path to the file to delete.")

    @field_validator('file_path')
    @classmethod
    def check_path(cls, v): return validate_no_placeholder_paths(v)

class ModifyNode(BaseModel):
    action: Literal["modify_node"] = "modify_node"
    file_path: str = Field(..., description="Path to the file to modify.")
    target_node_signature: str = Field(..., description="The function or class name to replace (e.g., 'my_func' or 'MyClass.my_method').")
    proposed_replace_string: str = Field(..., description="The NEW complete code for that node (function/class).")

    @field_validator('file_path')
    @classmethod
    def check_path(cls, v): return validate_no_placeholder_paths(v)

class AddImport(BaseModel):
    action: Literal["add_import"] = "add_import"
    file_path: str = Field(..., description="Path to the file to modify.")
    import_statement: str = Field(..., description="The import statement to add (e.g., 'import os' or 'from typing import Any').")

    @field_validator('file_path')
    @classmethod
    def check_path(cls, v): return validate_no_placeholder_paths(v)

class MoveNode(BaseModel):
    action: Literal["move_node"] = "move_node"
    source_file: str = Field(..., description="Path to the file to move the node FROM.")
    target_file: str = Field(..., description="Path to the file to move the node TO.")
    node_signature: str = Field(..., description="The function or class name to move (e.g., 'my_func' or 'MyClass.my_method').")
    required_imports: List[str] = Field(
        default=[], 
        description="List of import statements required for this node to run in the target file (e.g., ['import csv', 'from typing import Any'])."
    )

    @field_validator('source_file', 'target_file')
    @classmethod
    def check_path(cls, v): return validate_no_placeholder_paths(v)

class InsertNode(BaseModel):
    action: Literal["insert_node"] = "insert_node"
    file_path: str = Field(..., description="Path to the existing file.")
    new_node_code: str = Field(..., description="The complete code for the new function or class.")
    target_class_signature: Optional[str] = Field(None, description="If inserting a method into an existing class, provide the class name here (e.g., 'AbstractOrder'). Leave null for global functions.")
    
    @field_validator('file_path')
    @classmethod
    def check_path(cls, v): return validate_no_placeholder_paths(v)

class UpdateDocstring(BaseModel):
    action: Literal["update_docstring"] = "update_docstring"
    file_path: str = Field(..., description="Path to the file.")
    target_node_signature: str = Field(..., description="The function or class name.")
    new_docstring: str = Field(..., description="The new docstring text, including quotes.")

    @field_validator('file_path')
    @classmethod
    def check_path(cls, v): return validate_no_placeholder_paths(v)

class DeleteLines(BaseModel):
    action: Literal["delete_lines"] = "delete_lines"
    file_path: str = Field(..., description="Path to the file.")
    exact_string_match: str = Field(..., description="The exact line(s) of code to delete (e.g., 'Field.register_lookup(ReverseStartsWith)').")

    @field_validator('file_path')
    @classmethod
    def check_path(cls, v): return validate_no_placeholder_paths(v)

# --- Define the dynamic Unions (Phase 1: Dynamic Schema Pruning) ---
class RefactorProposalSafe(BaseModel):
    """Schema used for standard refactoring. DeleteFile is mathematically impossible."""
    actions: List[Union[CreateFile, ModifyNode, AddImport, MoveNode, InsertNode, UpdateDocstring, DeleteLines]] = Field(..., description="A list of safe refactoring actions.")

class RefactorProposalUnsafe(BaseModel):
    """Schema used ONLY when the user explicitly requests a deletion."""
    actions: List[Union[CreateFile, DeleteFile, ModifyNode, AddImport, MoveNode, InsertNode, UpdateDocstring, DeleteLines]] = Field(..., description="A list of refactoring actions, including deletion.")

class RefactorProposal(BaseModel):
    actions: List[Union[CreateFile, DeleteFile, ModifyNode, AddImport, MoveNode, InsertNode, UpdateDocstring, DeleteLines]] = Field(..., description="A list of discrete refactoring actions.")


# --- Config ---
MODEL_NAME = "qwen2.5-coder:14b-instruct-q4_K_M"

# Global Parser setup
PY_LANGUAGE = Language(tspython.language())
parser = Parser(PY_LANGUAGE)

async def generate_streaming_json(system_prompt: str, user_prompt: str, response_model: BaseModel) -> AsyncGenerator[str, None]:
    """
    Streams tokens from Ollama while enforcing the Pydantic schema (Step 2: Constrained Decoding).
    """
    client = ollama.AsyncClient()
    schema = response_model.model_json_schema()
    
    async for part in await client.chat(
        model=MODEL_NAME,
        messages=[
            {'role': 'system', 'content': f"{system_prompt}\nReturn ONLY valid JSON matching this schema: {json.dumps(schema)}"},
            {'role': 'user', 'content': user_prompt}
        ],
        format=schema,
        stream=True,
        options={'temperature': 0.1}
    ):
        yield part['message']['content']

def get_node_indent(source_code: str, start_byte: int) -> str:
    """Calculates the exact indentation of the line where a node starts."""
    # Find the start of the line containing the start_byte
    line_start = source_code.rfind('\n', 0, start_byte) + 1
    line_text = source_code[line_start:start_byte]
    # Return just the whitespace
    return line_text[:-len(line_text.lstrip())]

def get_base_indent(source_code: str, byte_offset: int) -> str:
    """Finds the whitespace indentation level at a specific byte offset."""
    lines = source_code[:byte_offset].split('\n')
    last_line = lines[-1] if lines else ""
    return last_line[:-len(last_line.lstrip())]

def extract_name_from_signature(signature: str) -> str:
    """Extracts the base name from a signature (e.g., 'MyClass.my_method' -> 'my_method')."""
    return signature.split('.')[-1]

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
            ] @def )
        )
        """)
    else:
        query = PY_LANGUAGE.query(f"""
        (function_definition name: (identifier) @n (#eq? @n "{clean_sig}")) @def
        (class_definition name: (identifier) @n (#eq? @n "{clean_sig}")) @def
        (decorated_definition (function_definition name: (identifier) @n (#eq? @n "{clean_sig}"))) @def
        """)

    captures = query.captures(tree.root_node)
    if isinstance(captures, dict):
        nodes = captures.get('def', [])
        if nodes: return nodes[0].start_byte, nodes[0].end_byte
    elif captures:
        for node, name in captures:
            if name == 'def': return node.start_byte, node.end_byte
    return None

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
        common_path = os.path.commonpath(known_paths)
        # Fix: Ensure we extract the directory if the common path is actually a file
        # This prevents NotADirectoryError when master_state only has one file
        if common_path in known_paths:
            common_dir = os.path.dirname(common_path)
        else:
            common_dir = common_path
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

def calculate_checksum(content: str) -> str:
    import hashlib
    return hashlib.md5(content.encode('utf-8')).hexdigest()

def path_to_python_module(filepath: str) -> str:
    """Converts a file path to a python module path without destroying app namespaces."""
    path = filepath
    if path.endswith(".py"): path = path[:-3]
    
    # ONLY strip src/ or other top-level project wrappers. 
    # Do NOT strip 'oscar/' as that is the actual root package namespace.
    if path.startswith("src/"):
        path = path[4:]
        
    return path.replace("/", ".").replace("\\", ".")

def execute_graph_query(query: str, parameters: dict = None) -> list:
    """Executes a Cypher query and returns the results as a list of dictionaries."""
    with driver.session() as session:
        result = session.run(query, parameters or {})
        return [record for record in result]

def apply_actions_to_state(master_state: Dict[str, str], actions: List[Union[CreateFile, DeleteFile, ModifyNode, AddImport, MoveNode]], original_checksums: Dict[str, str] = None, intent: str = "") -> Dict[str, str]:
    """
    Programmatically applies surgical actions (Phase 2 Upgrade).
    """
    new_state = master_state.copy()
    for action in actions:
        # 1. Resolve the path dynamically (Phase 1: Repo-Agnostic Path Resolution)
        path = resolve_path(action.file_path if hasattr(action, 'file_path') else "", master_state)
        
        # Step 3A: Pre-flight checksum check
        if original_checksums and path in original_checksums and path in new_state:
            current_content = fetch_file_content(path)
            if current_content and calculate_checksum(current_content) != original_checksums[path]:
                print(f"❌ STATE_MUTATION_DETECTED: {path} was modified externally. Aborting action.")
                continue

        if action.action == "create_file":
            # 2. Block destructive overwrites (Phase 2: State Machine Guardrails)
            if path in master_state:
                raise ValueError(
                    f"Action Rejected: Cannot use 'create_file' on existing file '{path}'. "
                    f"You MUST use 'modify_node' or 'add_import'."
                )
            new_state[path] = action.content
            print(f"   🆕 Created file: {path}")

        elif action.action == "delete_file":
            # Phase 5: Forbidding Phantom Deletions
            if "delete" not in intent.lower() and "remove" not in intent.lower():
                raise ValueError(
                    f"Action Rejected: 'delete_file' on '{path}' is not allowed unless the intent explicitly mentions deletion. "
                    f"To remove code, use 'modify_node' instead."
                )
            if path in new_state:
                del new_state[path]
                print(f"   🗑️ Deleted file: {path}")

        elif action.action == "modify_node":
            if path not in new_state:
                print(f"❌ Modify Error: File {path} not found in state.")
                continue
            content = new_state[path]
            
            # Find original node text for volume check
            node_range = find_node_range(content, action.target_node_signature)
            if node_range:
                start, end = node_range
                original_node_text = content[start:end]
                
                # PHASE 2: The Ruthless No-Wipe Shield (Milestone 3.6.7)
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

            # Phase 1: LibCST Whitespace Normalization (Milestone 3.6.7)
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
                print(f"   🔄 [LibCST] Modified {action.target_node_signature} (Decorators Preserved)")
            except Exception as e:
                raise ValueError(f"LibCST modification failed for '{action.target_node_signature}': {e}")

        elif action.action == "move_node":
            source_path = resolve_path(action.source_file, master_state)
            target_path = resolve_path(action.target_file, master_state)
            
            if source_path not in new_state:
                print(f"❌ Move Error: Source file {source_path} not found in state.")
                continue
            
            source_content = new_state[source_path]
            node_range = find_node_range(source_content, action.node_signature)
            if not node_range:
                print(f"❌ Move Error: Node '{action.node_signature}' not found in {source_path}.")
                continue
            
            start, end = node_range
            node_code = source_content[start:end]
            
            # Phase 6: AST Collision Check
            target_content = new_state.get(target_path, "")
            if target_content:
                target_namespace = get_namespace_identifiers(target_content)
                moved_node_name = extract_name_from_signature(action.node_signature)
                if moved_node_name in target_namespace:
                    raise ASTCollisionError(
                        f"Namespace Collision: Cannot move '{moved_node_name}' to '{target_path}'. "
                        f"The target file already contains a class, function, or import with the exact same name. "
                        f"Please use 'modify_node' to alias the existing identifier in the target file before moving."
                    )

            # 1. Pop from source
            new_state[source_path] = source_content[:start] + source_content[end:]
            # Clean up potential double newlines or artifacts (basic)
            new_state[source_path] = new_state[source_path].replace("\n\n\n", "\n\n")
            
            # 2. Append to target (Phase 3: Explicit MoveNode Dependency Injection)
            if target_path not in new_state:
                new_state[target_path] = ""
            
            # Construct the import block
            import_block = ""
            if hasattr(action, 'required_imports') and action.required_imports:
                import_block = "\n".join(action.required_imports) + "\n\n"

            existing_content = new_state.get(target_path, "")
            # Avoid duplicating imports if they already exist
            if import_block.strip() and import_block.strip() not in existing_content:
                new_state[target_path] = import_block + existing_content + "\n\n" + node_code
            else:
                new_state[target_path] = existing_content + ("\n\n" if existing_content else "") + node_code
            
            print(f"   🚀 Moved node '{action.node_signature}' from {source_path} to {target_path}")

            # Phase 2: Graph-Automated Downstream Imports
            # 1. Query Neo4j to find downstream consumers
            node_name = extract_name_from_signature(action.node_signature)
            cypher_query = f"""
            MATCH (f:File)-[:IMPORTS]->(n:Node {{name: $node_name}})
            RETURN f.path as affected_path
            """
            affected_records = execute_graph_query(cypher_query, {"node_name": node_name})
            affected_files = [r["affected_path"] for r in affected_records]

            # 2. Deterministic Python string replacement (Milestone 3.6.8 Phase 4)
            old_module_path = path_to_python_module(source_path)
            new_module_path = path_to_python_module(target_path)

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
                    print(f"   ⚓ Automatically updated downstream import in {file_path}")

        elif action.action == "add_import":
            if path not in new_state:
                new_state[path] = ""
            content = new_state[path]
            if action.import_statement not in content:
                # Add at the top
                new_state[path] = action.import_statement + "\n" + content
                print(f"   ⚓ Added import to {path}: {action.import_statement}")

        elif action.action == "insert_node":
            if path not in new_state: continue
            content = new_state[path]
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
                            if original_node.name.value == action.target_class_signature.split('.')[-1]:
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
                print(f"   ➕ Inserted new node into {path}")
                
            except Exception as e:
                raise ValueError(f"LibCST parsing failed for new node: {e}")

        elif action.action == "update_docstring":
            if path not in new_state: continue
            content = new_state[path]
            try:
                source_tree = cst.parse_module(content)
                # Parse the new docstring string into a SimpleStatementLine
                clean_doc = action.new_docstring.strip('"').strip("'")
                new_doc_node = cst.parse_module(f'"""{clean_doc}"""').body[0]
                
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

        elif action.action == "delete_lines":
            if path in new_state:
                content = new_state[path]
                if action.exact_string_match in content:
                    new_state[path] = content.replace(action.exact_string_match, "")
                    # Clean up blank lines left behind
                    new_state[path] = re.sub(r'\n\s*\n', '\n\n', new_state[path])
                    print(f"   ✂️ Deleted specified lines from {path}")
        
    return new_state

def apply_updates(file_updates: Dict[str, str], original_checksums: Dict[str, str] = None):
    """Writes changes to disk with strict checksum verification (Step 3A)."""
    for path, content in file_updates.items():
        if original_checksums and path in original_checksums:
            disk_content = fetch_file_content(path)
            if disk_content and calculate_checksum(disk_content) != original_checksums[path]:
                print(f"❌ CRITICAL: State mismatch for {path} just before write. Aborting.")
                continue

        dir_name = os.path.dirname(path)
        if dir_name:
            os.makedirs(dir_name, exist_ok=True)
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"   💾 Persisted changes to {path}")

def fetch_file_content(path: str) -> Optional[str]:
    try:
        with open(path, 'r', encoding='utf-8') as f: return f.read()
    except: return None

# --- Graph Engine ---
NEO4J_URI, NEO4J_AUTH = "bolt://localhost:7687", ("neo4j", "password")
embedder = SentenceTransformer('all-MiniLM-L6-v2')
driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)

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

def get_hybrid_context(instruction: str) -> Dict[str, List[str]]:
    """Phase 1: Dynamic Context Scoping. Pulls entire file AST if 'audit' intent detected."""
    context_map = {}
    
    # Heuristic for intent-based scoping
    audit_match = re.search(r"(audit|all functions in|all classes in|everything in)\s+([a-zA-Z0-9_\-\./]+)", instruction, re.IGNORECASE)
    
    if audit_match:
        target_path = audit_match.group(2)
        print(f"🔍 Intent Detected: Full-file audit for '{target_path}'. Bypassing vector search.")
        with driver.session() as session:
            # Query all functions and classes for this file
            query = """
            MATCH (n) 
            WHERE (n:Function OR n:Class) AND n.file ENDS WITH $target_path
            RETURN n.name, n.file
            """
            result = session.run(query, target_path=target_path)
            for record in result:
                f = record['n.file']
                if f not in context_map: context_map[f] = []
                context_map[f].append(record['n.name'])
        
        if context_map:
            return context_map

    # Fallback to vector search (K=5)
    query_vector = embedder.encode(instruction).tolist()
    with driver.session() as session:
        result = session.run("CALL db.index.vector.queryNodes('function_embeddings', 5, $embedding) YIELD node AS anchor, score WHERE score > 0.65 RETURN anchor.name, anchor.file", embedding=query_vector)
        for record in result:
            f = record['anchor.file']
            if f:
                if f not in context_map: context_map[f] = []
                context_map[f].append(record['anchor.name'])
    return context_map

# --- CLI Execution ---
async def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-y", "--yes", action="store_true")
    parser.add_argument("--local", action="store_true")
    parser.add_argument("--blueprint-export", type=str, help="Generate a TaskList JSON and save it to the provided path.")
    parser.add_argument("--drive-spec", type=str, help="Load a TaskList JSON from a file and execute it.")
    args, unknown_args = parser.parse_known_args()

    task_list = None
    intent = ""
    if args.drive_spec:
        print(f"📂 Loading specification from: {args.drive_spec}")
        try:
            with open(args.drive_spec, 'r') as f:
                spec_data = json.load(f)
            task_list = TaskList.model_validate(spec_data)
            intent = spec_data.get('intent', "Executing loaded specification")
        except Exception as e:
            print(f"❌ Error loading spec: {e}")
            return
    else:
        intent = " ".join(unknown_args) if unknown_args else input("Enter Refactor Intent: ")
        print(f"\n🧠 Gathering context for intent: {intent}")
        context_map = get_hybrid_context(intent)
        
        if not context_map:
            print("No relevant code found.")
            sys.exit(0)

        print(f"   ✅ Found context in files: {list(context_map.keys())}")
        
        # Step 2A: The Native Gatekeeper
        for path in context_map:
            content = fetch_file_content(path)
            if content:
                valid, error = is_semantically_valid(content)
                if not valid:
                    print(f"❌ Syntax/Semantic Error detected in {path}: {error}. Aborting main pipeline for triage.")
                    return

        task_sys_prompt = (
            "You are a senior architect. Generate a sequential list of refactoring tasks.\n"
            "CRITICAL: You MUST identify the 'primary_target_files'. These are the files you are explicitly asked to refactor or audit. "
            "Do NOT include files that are only provided for context or that might need minor caller updates."
        )
        task_user_prompt = f"INSTRUCTION: {intent}\nCONTEXT: {json.dumps(context_map)}"
        
        print("\n🧠 Generating Refactoring Plan...")
        full_task_json = ""
        async for token in generate_streaming_json(task_sys_prompt, task_user_prompt, TaskList):
            full_task_json += token
            print(token, end="", flush=True)
        print("\n")
        
        try:
            task_list = TaskList.model_validate_json(full_task_json)
            if args.blueprint_export:
                with open(args.blueprint_export, 'w', encoding='utf-8') as f:
                    json.dump(task_list.model_dump(), f, indent=2)
                print(f"✅ Blueprint exported to {args.blueprint_export}")
                return
        except Exception as e:
            print(f"❌ Failed to parse tasks: {e}")
            return

    # Extract all files mentioned in the task list
    all_files = set()
    for task in task_list.tasks:
        all_files.update(task.context.keys())

    # Fetch initial file state and checksums (Step 3A)
    master_state = {}
    master_checksums = {}
    for path in all_files:
        content = fetch_file_content(path)
        if content:
            master_state[path] = content
            master_checksums[path] = calculate_checksum(content)
    
    # Phase 1: Dynamic Schema Pruning
    user_intent_lower = intent.lower()
    # Only allow DeleteFile if they explicitly ask to delete a FILE or MODULE.
    requires_deletion = bool(re.search(r'\b(delete|remove|drop)\s+(the\s+)?(file|module|script)\b', user_intent_lower))
    ActiveSchema = RefactorProposalUnsafe if requires_deletion else RefactorProposalSafe
    print(f"🛡️  Using active schema: {ActiveSchema.__name__}")

    # Phase 3: The "Do No Harm" Task Abort tracking (Milestone 3.6.7)
    failed_critical_tasks = False

    # Determine if we should activate strict focus mode (Milestone 3.6.8 Phase 5)
    audit_keywords = ["audit", "standardize", "comprehensive", "clean up"]
    is_audit_mode = any(word in intent.lower() for word in audit_keywords)

    for i, task in enumerate(task_list.tasks):
        print(f"\n--- Executing Task {i+1}/{len(task_list.tasks)}: {task.task} ---")
        
        # Abort downstream modifications if a critical node creation failed earlier
        if failed_critical_tasks:
            print(f"⚠️ Skipping Task {i+1} to prevent downstream breakage from earlier failures.")
            continue
        
        # Phase 3: Precision Routing via Sub-Tree GraphRAG (Upgraded for Milestone 3.6.8 Phase 5)
        context_blocks = []
        
        # 1. Provide FULL content for explicitly targeted files
        for target_path in task_list.primary_target_files:
            content = master_state.get(target_path, "")
            if content:
                context_blocks.append(f'<target_file path="{target_path}">\n{content}\n</target_file>')

        # 2. Provide nodes or skeletons for other files in task context
        for path, node_names in task.context.items():
            if path in task_list.primary_target_files:
                continue # Already provided full content
                
            content = master_state.get(path, "")
            if not content: continue
            
            if is_audit_mode:
                # Provide only the structural skeleton to avoid context overload
                skeleton = get_file_skeleton(content)
                context_blocks.append(f'<context_file path="{path}" note="TRUNCATED SKELETON FOR REFERENCE">\n{skeleton}\n</context_file>')
            else:
                # Provide the specific nodes requested
                file_block = f'<file_context path="{path}">'
                for node_name in node_names:
                    node_range = find_node_range(content, node_name)
                    if node_range:
                        start, end = node_range
                        node_code = content[start:end]
                        file_block += f'\n<node signature="{node_name}">\n{node_code}\n</node>'
                file_block += "\n</file_context>"
                context_blocks.append(file_block)
            
        # NEW: Fetch Parent Class Context
        parent_context_xml = ""
        for path, node_names in task.context.items():
            for node_name in node_names:
                # In python, extract just the class name if it is a method, but for simplicity we can try the raw node_name
                # since the cypher query requires `Class` label it will gracefully return empty for methods.
                base_node_name = node_name.split('.')[0] if '.' in node_name else node_name
                cypher_query = """
                MATCH (c:Class {name: $class_name})-[:INHERITS_FROM*1..2]->(parent:Class)-[:HAS_METHOD]->(method:Function)
                RETURN parent.name AS parent, method.name AS sig, method.docstring AS doc
                """
                results = execute_graph_query(cypher_query, {'class_name': base_node_name})
                if results:
                    # To avoid duplicates if we query the same class multiple times
                    if f"<parent_class_context name='{base_node_name}'>" not in parent_context_xml:
                        parent_context_xml += f"\n<parent_class_context name='{base_node_name}'>\n"
                        for row in results:
                            parent_context_xml += f"  <inherited_method parent='{row['parent']}' signature='{row['sig']}'>\n"
                            parent_context_xml += f"    {row['doc']}\n  </inherited_method>\n"
                        parent_context_xml += "</parent_class_context>\n"
        
        context_str = "\n\n".join(context_blocks) + parent_context_xml
        
        sys_prompt = (
            "You are an elite Principal AI Engineer refactoring a complex Python monolith. "
            "CRITICAL RULES: \n"
            "1. NO HALLUCINATIONS: You MUST strictly use the variables, kwargs, and attributes exactly as they appear in the provided file context. Do not invent `self.order_number` if the code uses `self.number`. Do not invent exception names.\n"
            "2. ABSOLUTE IMPORTS ONLY: Never use relative imports (like `from . import lookups`). ALL imports must be absolute paths from the project root (e.g., `from oscar.core.models import lookups`).\n"
            "3. SCOPE AWARENESS: Do not use `self` inside global utility functions, static decorators, or outside of a Class instance.\n"
            "4. NO DUMMY LOGIC: When extracting or modifying code, preserve the EXACT original business logic. Never use placeholders like `pass`.\n"
            "5. NO CONTEXT WANDERING: You will be provided with context files to help you understand the codebase. Do NOT modify these context files unless explicitly required to update a caller. If asked to audit a specific file, restrict 100% of your docstring/formatting updates to that specific file.\n"
            "6. EXTRACTION COMPLETENESS: If extracting logic, you MUST output the full extracted utility function, and you MUST update the original caller to use it.\n"
        )
        user_prompt = f"CONTEXT:\n{context_str}\n\nINSTRUCTION:\n{task.task}\n\nOutput MUST strictly conform to the Pydantic Action Union. DO NOT modify any code outside the provided node bounds."
        
        max_retries = 3
        retry_count = 0
        error_msg = ""
        
        while retry_count < max_retries:
            if error_msg:
                print(f"   🔄 Self-Healing Retry {retry_count}/{max_retries} due to: {error_msg}")
                current_user_prompt = f"{user_prompt}\n\nPREVIOUS ATTEMPT FAILED WITH ERROR: {error_msg}\nPlease correct the indentation or syntax and retry."
            else:
                current_user_prompt = user_prompt
                print("🧠 Generating Actions...", end="")

            full_patch_json = ""
            async for token in generate_streaming_json(sys_prompt, current_user_prompt, ActiveSchema):
                full_patch_json += token
            print(" Done.\n")
            
            try:
                proposal = ActiveSchema.model_validate_json(full_patch_json)
                new_state = apply_actions_to_state(master_state, proposal.actions, master_checksums, intent=intent)
                
                # Track modified paths for Phase 2: Differential Static Analysis
                modified_paths = []
                for path, new_content in new_state.items():
                    if master_state.get(path) != new_content:
                        modified_paths.append(path)

                # Step 3: Verification
                syntax_error = False
                for path in modified_paths:
                    if path.endswith(".py") and path in new_state:
                        valid, error = is_semantically_valid(new_state[path])
                        if not valid:
                            error_msg = f"Verification failed for {path}: {error}"
                            syntax_error = True
                            break
                            
                        # Format and Validate
                        valid, error, formatted_content = format_and_validate_python(new_state[path], filepath=path)
                        if not valid:
                            error_msg = f"Formatting/Validation failed for {path}: {error}"
                            syntax_error = True
                            break
                        else:
                            new_state[path] = formatted_content
                
                if not syntax_error:
                    # Phase 2: Dual-Workspace Differential Static Analysis (Milestone 3.6.6)
                    valid, error = validate_virtual_workspace(master_state, new_state, modified_paths)
                    if not valid:
                        error_msg = error
                        syntax_error = True

                if not syntax_error:
                    # Show diff and confirm
                    print("\n🔍 REVIEW PROPOSED CHANGES:")
                    has_changes = False
                    for path in modified_paths:
                        old_content = master_state.get(path, "")
                        new_content = new_state[path]
                        has_changes = True
                        print(f"\n--- File: {path} ---")
                        diff = difflib.unified_diff(old_content.splitlines(keepends=True), new_content.splitlines(keepends=True), fromfile=f"a/{path}", tofile=f"b/{path}", lineterm="")
                        for line in diff:
                            print(line.rstrip())
                    
                    if not has_changes:
                        print("No changes proposed for this task. Skipping confirmation.")
                        break # Exit retry loop and move to next task
                            
                    print(f"\nApply changes for Task {i+1}? (y/n): ", end="", flush=True)
                    confirm = 'y' if args.yes else sys.stdin.readline().strip().lower()
                    if confirm == 'y':
                        master_state.update(new_state)
                        print("✅ Changes accepted in-memory.")
                        break # Exit retry loop
                    else:
                        print("🛑 Task rejected. Skipping.")
                        break # Skip this task and continue
                else:
                    retry_count += 1
            except Exception as e:
                error_msg = str(e)
                retry_count += 1
        
        if retry_count == max_retries:
            # Phase 4: Atomic "Best Effort" Execution
            print(f"❌ Task {i+1} failed after {max_retries} attempts. Skipping to next task.")
            
            # Phase 3 Part 2 (Milestone 3.6.7): Detect if this was a critical node creation
            # We look at the proposed actions if we have them from the last attempt
            try:
                # We check the task list description or the last failed proposal
                is_critical = "create" in task.task.lower() or "insert" in task.task.lower() or "add" in task.task.lower()
                if is_critical:
                    print(f"🛑 CRITICAL FAILURE: Node creation/insertion failed. Arming 'Do No Harm' shield for downstream tasks.")
                    failed_critical_tasks = True
            except:
                pass
                
            continue
            
    print("\n💾 Writing all changes to disk...")
    apply_updates(master_state, master_checksums)
    print("✅ Complete.")


if __name__ == "__main__":
    asyncio.run(main())
