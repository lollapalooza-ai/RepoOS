Implement this requirement:
To build the **"Subway Map" (User Journey View)**, we must bridge the gap between the *imperative call graph* you currently have in Neo4j (created by `ingest2.py`) and the *declarative business flow* a Product Manager understands.

Currently, `ingest2.py` gives us a "City Map" (every building and street). The PM needs a "Transit Map" (just the major stops).

Here is the architectural strategy and implementation plan to build the **Subway Map Generator** using your existing stack.

---

### **1. The Architecture: The "Journey Mapper" Pipeline**

We cannot rely solely on static analysis to define "stations" because code doesn't always look like a business process. We will use a **Hybrid Approach**: Graph Traversal for structure + AI for semantic labeling.

**The 3-Step Pipeline:**

1. 
**Anchor Identification:** Find the entry points (already captured as `route` in `ingest2.py` ).


2. **Trace Extraction:** Traverse the graph from the Anchor to find the "Blast Radius" of execution.
3. **Semantic Compression (The "Station" Logic):** Use the LLM (via `refactor2.py` patterns) to compress 50 function calls into 5-7 distinct "Stations."

---

### **2. Implementation: The `mapper.py` Module**

We use the module, `mapper.py`. This module will interface with Neo4j and Ollama.

#### **Step A: Extract the Raw Trace (Graph Layer) (Ignore if mapper.py already has this)**

We need a Cypher query that starts at a user-facing route (e.g., `/checkout`) and grabs the downstream flow.

*Add this function to your interaction layer:*

```python
def get_trace_for_route(driver, route_path):
    """
    Retrieves the execution trace starting from a specific API route.
    Returns a subgraph of functions called within 3 hops (depth).
    """
    query = """
    MATCH (start:Function) WHERE start.route = $route
    // Find outbound calls up to 3 levels deep to limit noise
    CALL apoc.path.subgraphAll(start, {
        relationshipFilter: "CALLS>",
        minLevel: 0,
        maxLevel: 3
    })
    YIELD nodes, relationships
    RETURN nodes, relationships
    """
    # Note: If APOC is not available, we can use standard variable-length paths:
    # MATCH path = (start:Function {route: $route})-[:CALLS*1..3]->(end)
    # RETURN path
    
    with driver.session() as session:
        result = session.run(query, route=route_path)
        return result.data()

```

#### **Step B: The "Station" Agent (AI Layer) (Ignore if mapper.py already has this)**

This is the core differentiator. We will feed the raw list of functions to the LLM and ask it to "group and label" them into stations.

*Prompt Strategy:*
We don't want code; we want a JSON object representing the map.

```python
def generate_subway_map(route, raw_trace_data):
    """
    Uses the LLM to convert a list of function names into a User Journey.
    """
    # 1. Flatten the graph data into a text list for the prompt
    function_list = [n['name'] for n in raw_trace_data['nodes']]
    
    system_prompt = """
    You are a Product Manager visualizing a legacy codebase.
    Your goal is to convert a raw list of Python function calls into a high-level "Subway Map" User Journey.
    
    RULES:
    1. Group related functions into "Stations" (e.g., 'validate_email', 'check_password' -> 'Login Station').
    2. The map must be linear or slightly branching (max 5-7 stations).
    3. Identify "Friction Points": If a function implies complexity (e.g., 'retry_payment', 'handle_error'), flag the station as 'At Risk'.
    
    Output JSON format:
    {
      "journey_name": "Checkout Flow",
      "stations": [
        {"name": "Cart Review", "functions": ["get_cart", "calc_total"], "status": "OK"},
        {"name": "Payment", "functions": ["stripe_charge", "retry_logic"], "status": "RISK", "risk_reason": "Heavy retry logic detected"}
      ]
    }
    """

    user_content = f"Route: {route}\nRaw Function Trace: {function_list}"

    # Reuse your existing ollama connection from refactor2.py
    response = ollama.chat(
        model="qwen2.5-coder:14b-instruct-q4_K_M", # Or your configured model
        messages=[
            {'role': 'system', 'content': system_prompt},
            {'role': 'user', 'content': user_content}
        ],
        format='json'
    )
    return json.loads(response['message']['content'])

```

---

### **3. Integrating Visual Signals (The "Insight")**

The prompt specifically asks for "Friction Points" and "Logic Errors". We can algorithmically derive these before sending data to the LLM to make the insight grounded in reality, not hallucination.

**Update `ingest2.py` to calculate "Heat":**
We can add a complexity score during ingestion.

*Modify `ingest2.py` around line 538 (write_function_node):*

```python
# In ingest2.py
def calculate_complexity(source_code):
    """
    Simple heuristic: Count 'if', 'for', 'while', 'try' statements.
    """
    complexity = 0
    keywords = ['if ', 'for ', 'while ', 'try:', 'except ', 'with ']
    for word in keywords:
        complexity += source_code.count(word)
    return complexity

# Update the graph write function
def write_function_node(func_name, file_path, source_code, ...):
    complexity_score = calculate_complexity(source_code)
    
    query = """
    MERGE (f:Function {name: $name})
    ON CREATE SET ..., f.complexity = $complexity
    ...
    """
    # ... pass complexity to the query

```

**Using the Signal:**
When `mapper.py` queries the graph, it now pulls `f.complexity`.

* If `complexity > 20`: The station is colored **Yellow**.
* If `complexity > 50`: The station is colored **Red** (Friction Point).

---

### **4. The Final Output (Visualizing for the PM)**

You requested how to *show* this. Since you are running locally, you can output a simple ASCII representation (like the "Blueprint" in `refactor2.py` ) or a Mermaid.js diagram.

*Add this visualizer to `mapper.py`:*

```python
def render_ascii_subway_map(journey_json):
    print(f"\n🚇 SUBWAY MAP: {journey_json['journey_name']}")
    print("START " + "=" * 50 + " END")
    
    stations = journey_json['stations']
    
    # Print the Line
    line_visual = ""
    for station in stations:
        symbol = "O"
        if station['status'] == 'RISK': symbol = "X"
        line_visual += f"---[{symbol}]---"
    print(line_visual)
    
    # Print the Labels
    for i, station in enumerate(stations):
        status_icon = "✅" if station['status'] == 'OK' else "⚠️"
        print(f"Station {i+1}: {station['name']} {status_icon}")
        if 'risk_reason' in station:
            print(f"    └── Issue: {station['risk_reason']}")
            print(f"    └── Code: {', '.join(station['functions'][:3])}...")

```

### **Summary of Work Required**

1. **Ingestion (`ingest2.py`):** Add `complexity` metrics to nodes so we have real data for "Friction Points."
2. **Mapping (`mapper.py`):** Create the script that:
* Finds a Route (Entry Point).
* Crawls the Call Graph (Dependencies).
* Uses LLM to summarize clusters of functions into "Stations."


3. **Visualization:** Output the JSON/ASCII map.

This directly fulfills the "Subway Map" requirement by translating *imperative* code (functions) into *declarative* intent (stations) using the AI as the translator.