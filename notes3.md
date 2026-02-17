We want to make the blueprint we generate (both --blueprint and --blueprint-export options) to make spec-driven development. Below are the instructions on how to make it. 
Note that we want to retain all the existing sections (like background, justification, existing architecture, proposed architecture, etc) and add a new section called "Implementation Plan" at the end of the blueprint.
The "Implementation Plan" section should include the spec-driven development checklists. 

Here is the step-by-step implementation plan to modify `refactor2.py` and your workflow to support **Spec-Driven Development (SDD)** via the JSON Blueprint.
Ignore anything that already exists.

---

### **Phase 1: The New "Mental Model"**

We are changing the output of your AI.

* **Old:** "Write a plan." -> AI vomits Markdown text.
* **New:** "Design a Spec." -> AI builds a **JSON Graph**.

This JSON Graph isn't just for display; it's a **Task Dependency Tree**.

* **Root:** The Feature (e.g., "Auth Refactor").
* **Branch:** The Component (e.g., "Database Schema").
* **Leaf:** The Atomic Task (e.g., "Add `auth_provider` column to `users` table").

---

### **Phase 2: Modify `refactor2.py**`

We need to force the LLM to output valid Tiptap JSON. We will use a **"Schema-Enforced System Prompt"** pattern.

#### **1. Define the Schema (The "Contract")**

Update `refactor2.py` with this :

```python
# refactor2.py

TIPTAP_SYSTEM_PROMPT = """
You are a Principal Software Architect. Your goal is to design a concrete implementation plan.
DO NOT output conversational text.
DO NOT output Markdown.
Output ONLY a valid JSON object matching the Tiptap schema structure below.

Structure Rules:
1. Root object must be { "type": "doc", "content": [...] }
2. Use "heading" nodes for sections (Level 1: Title, Level 2: Component).
3. Use "paragraph" nodes for architectural reasoning.
4. Use "taskList" and "taskItem" nodes for actionable steps.
5. Use "codeBlock" nodes for crucial snippets (schemas, signatures).

Example Output:
{
  "type": "doc",
  "content": [
    { "type": "heading", "attrs": { "level": 1 }, "content": [{ "type": "text", "text": "Plan: OAuth Migration" }] },
    { "type": "paragraph", "content": [{ "type": "text", "text": "We will replace MD5 with Auth0." }] },
    { "type": "taskList", "content": [
        { "type": "taskItem", "attrs": { "checked": false }, "content": [{ "type": "text", "text": "[Backend] Install Auth0 SDK" }] }
      ]
    }
  ]
}
"""

```

#### **2. Update the Generation Logic**

Modify your `generate_blueprint` function to use this prompt and parse the result.

```python
import json
import re

def clean_json_output(response_text): (ignore if already exists)
    """
    Sanitizes LLM output to extract just the JSON object.
    """
    # Remove markdown code fences if present
    response_text = re.sub(r'```json', '', response_text)
    response_text = re.sub(r'```', '', response_text)
    return response_text.strip()

def generate_blueprint_json(user_intent, context):
    """
    Generates a Tiptap-compatible JSON blueprint.
    """
    prompt = f"""
    CONTEXT:
    {context}

    USER INTENT:
    {user_intent}

    TASK:
    Create a detailed Spec-Driven Development plan for this intent.
    Break it down into:
    1. Executive Summary (Why?)
    2. Architecture Changes (What?)
    3. Step-by-Step Implementation Tasks (How?)
    """
    
    # Call your local LLM (Qwen/Llama)
    # response = llm_client.generate(system=TIPTAP_SYSTEM_PROMPT, user=prompt)
    
    # MOCK RESPONSE (For testing flow without model):
    mock_response = """
    {
      "type": "doc",
      "content": [
        { "type": "heading", "attrs": { "level": 1 }, "content": [{ "type": "text", "text": "Refactor: " + user_intent }] },
        { "type": "paragraph", "content": [{ "type": "text", "text": "This spec defines the migration path." }] },
        { "type": "taskList", "content": [
            { "type": "taskItem", "attrs": { "checked": false }, "content": [{ "type": "text", "text": "Step 1: Audit legacy code" }] },
            { "type": "taskItem", "attrs": { "checked": false }, "content": [{ "type": "text", "text": "Step 2: Create interface adapters" }] }
        ]}
      ]
    }
    """
    
    try:
        # data = json.loads(clean_json_output(response.text)) # Real Line
        data = json.loads(clean_json_output(mock_response)) # Mock Line
        return data
    except json.JSONDecodeError:
        print("Error: AI did not generate valid JSON.")
        return None

```

#### **3. The "Spec-Driven" CLI Commands**

Update your `main` block to handle the new `--blueprint` flag.

```python
if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("--blueprint", action="store_true", help="Generate a Spec JSON")
    parser.add_argument("--blueprint-export", type=str, help="Path to save JSON")
    args = parser.parse_args()

    if args.blueprint:
        intent = input("Enter Refactor Intent: ")
        blueprint = generate_blueprint_json(intent, "Load graph context here...")
        
        if args.blueprint_export:
            with open(args.blueprint_export, "w") as f:
                json.dump(blueprint, f, indent=2)
            print(f"Blueprint saved to {args.blueprint_export}")
        else:
            print(json.dumps(blueprint, indent=2))

```

---

### **Phase 3: The "Spec Driver" (Converting Spec -> Agent Tasks)**

This is the most critical part of **Spec-Driven Development**. You need a function that takes the *final* JSON (after you've edited it in React) and turns it into a series of commands for the Coding Agent.

Add this function to `refactor2.py` (or a new `spec_driver.py`).

```python
def drive_agent_from_spec(blueprint_json):
    """
    Parses the Tiptap JSON and executes tasks one by one.
    """
    tasks = []
    
    # 1. Walk the JSON tree to find 'taskItem' nodes
    def extract_tasks(node):
        if node['type'] == 'taskItem':
            # Extract text from the task
            task_text = node['content'][0]['text']
            is_checked = node['attrs'].get('checked', False)
            
            # Only execute unchecked tasks (allows resuming)
            if not is_checked:
                tasks.append(task_text)
        
        if 'content' in node:
            for child in node['content']:
                extract_tasks(child)
                
    extract_tasks(blueprint_json)
    
    print(f"Found {len(tasks)} actionable tasks in Spec.")
    
    # 2. Execute with Agent (One by One)
    for i, task in enumerate(tasks):
        print(f"\n--- Executing Task {i+1}/{len(tasks)}: {task} ---")
        
        # Construct the Prompt for the Agent
        agent_prompt = f"""
        You are a coding agent working on a larger refactor.
        
        CURRENT TASK:
        {task}
        
        Adhere strictly to this task. Do not hallucinate extra scope.
        """
        
        # Call your Agent (e.g., Aider, Claude, or local function)
        # execute_agent(agent_prompt)
        print("Agent finished task.")

```

### **Phase 4: The Workflow Summary**

1. **Generate:** `python refactor2.py --blueprint --blueprint-export spec.json`
2. **Visualise & Refine:** Open `spec.json` in your React/Tiptap Dashboard.
* *You act as the Architect.* You edit the text, reorder tasks, and fix assumptions.
* *You save the file.*


3. **Drive:** `python refactor2.py --drive-spec spec.json`
* The script reads your *refined* spec.
* It dispatches agents to do the work, checking off items as it goes.


Double check if you've included 1. existing architecture diagram (rendered using mermaid js) 2. proposed delta architecture diagram (also using mermaid js) 3. Only specs in implementation plan must be used
   when I run "--drive-spec" option, ignoring rest of the sections in the tiptap json.
