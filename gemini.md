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

Feedback v1:
We ran some tests and here is what we want to fix in RepoOS. It ignored your architectural constraint (use db.run_raw_sql).

Why? LLMs are trained to solve the problem (fix the bug), not necessarily to follow the process (use the helper), unless the process is framed as a hard constraint. The 14B model likely saw run_raw_sql as "optional context" rather than a "mandatory tool."

Here is the Repo OS v1.1 Upgrade Patch to enforce architectural compliance.

Feature 1: The "Constraint Extraction" Phase
We cannot rely on the LLM to "notice" your instruction inside a large prompt. We must extract the constraints first and treat them as high-priority rules.

Modify refactor.py to add this pre-processing step:

Python
def extract_constraints(instruction):
    """
    Uses a small, fast prompt to identify 'Must Haves' in the user instruction.
    """
    sys_prompt = """
    You are a Technical Project Manager. 
    Extract specific function calls, libraries, or patterns the user EXPLICITLY requested.
    Output JSON: {"must_use_functions": [], "must_use_libraries": [], "architectural_notes": ""}
    """
    
    response = ollama.chat(
        model=MODEL_NAME,
        messages=[
            {'role': 'system', 'content': sys_prompt},
            {'role': 'user', 'content': instruction}
        ],
        format='json',
        options={'temperature': 0.0}
    )
    return json.loads(response['message']['content'])

# USAGE IN ORCHESTRATOR:
# constraints = extract_constraints(instruction)
# print(f"🔒 Constraints Detected: {constraints}")
Feature 2: "Intent-Aware" Context Retrieval
If the user says "use db.run_raw_sql", we shouldn't just hope the vector search finds it. We must force the Graph to fetch that specific node's signature and docstring.

Update get_blast_radius or create a new fetch_mandated_tools function:

Python
def fetch_mandated_tools(constraints):
    """
    If the user asked for 'db.run_raw_sql', we fetch its signature from the Graph
    and tag it as MANDATORY in the context.
    """
    tool_context = ""
    
    # 1. Look for requested functions
    for func_name in constraints.get('must_use_functions', []):
        # Handle 'module.function' format
        clean_name = func_name.split('.')[-1] 
        
        # Query Graph for this specific function
        query = """
        MATCH (f:Function {name: $name})
        RETURN f.name, f.file, f.body
        """
        with driver.session() as session:
            result = session.run(query, name=clean_name).single()
            
        if result:
            tool_context += f"\n!!! MANDATORY TOOL !!!\n"
            tool_context += f"You MUST use the function '{result['f.name']}' defined in '{result['f.file']}':\n"
            # Optimization: Only show signature + docstring, not full body if too large
            tool_context += f"```python\n{result['f.body'][:500]}...\n```\n"
        else:
            print(f"⚠️ Warning: User asked for '{func_name}' but it was not found in the Graph.")
            
    return tool_context
Feature 3: The "Compliance Report" (Self-Reflection)
Finally, we force the AI to grade itself. Instead of just outputting code, it must output a "Refactor Report" explaining why it did what it did.

Update the Main System Prompt in refactor.py:

Python
system_prompt = f"""
You are a Principal Engineer. Refactor the code.

CRITICAL RULES:
1. {constraints_text} (These are hard constraints. You will be penalized for ignoring them.)
2. Output a JSON object with TWO fields:
   - "plan_report": A brief explanation of how you satisfied the specific constraints.
   - "file_changes": A dictionary of filename -> new_code.

Example Output:
{{
  "plan_report": "I fixed the SQL injection by using db.run_raw_sql as requested. I removed the 'conn.execute' calls.",
  "file_changes": {{ "app.py": "..." }}
}}
"""
Feature 4: The Code (Putting it together)
Here is the updated orchestrate_refactor function integrating all three improvements.

Python
def orchestrate_refactor_v2(target_name, instruction):
    # 1. EXTRACT CONSTRAINTS
    print("🕵️ Analyzing Instructions...")
    constraints = extract_constraints(instruction)
    
    if constraints['must_use_functions']:
        print(f"🔒 Architecture Lock: Must use {constraints['must_use_functions']}")

    # 2. FETCH STANDARD CONTEXT (Blast Radius)
    files_to_context, error = get_blast_radius(target_name)
    if error: return

    # 3. FETCH MANDATORY TOOL CONTEXT
    tool_context = fetch_mandated_tools(constraints)

    # 4. BUILD PROMPT
    constraint_str = ""
    if constraints['must_use_functions']:
        constraint_str = f"MANDATORY: You must implement the solution using: {', '.join(constraints['must_use_functions'])}."

    system_prompt = f"""
    You are a Senior Architect.
    Refactor the code to improve quality and security.
    
    {constraint_str}
    
    If the mandatory tools allow for a safe solution, PREFER them over writing new logic.
    
    Output JSON with 'plan_report' and 'file_changes'.
    """

    user_content = f"Instruction: {instruction}\n\n=== MANDATORY TOOLS ===\n{tool_context}\n\n=== CODEBASE ===\n"
    # ... (Add file contents as before) ...

    # 5. EXECUTE
    response = ollama.chat(...)
    
    # 6. PARSE & DISPLAY REPORT
    try:
        data = json.loads(response['message']['content'])
        
        # Show the "Thought Process" to the user
        print(f"\n{Colors.BOLD}📋 COMPLIANCE REPORT:{Colors.RESET}")
        print(f"{Colors.CYAN}{data.get('plan_report', 'No report generated.')}{Colors.RESET}")
        
        # Show Diff
        review_changes(original_state, data.get('file_changes', {}))
        
    except:
        print("Error parsing response.")
