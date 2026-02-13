import os
import json
import sys
from neo4j import GraphDatabase
import ollama

# --- CONFIGURATION ---
NEO4J_URI = "bolt://localhost:7687"
NEO4J_AUTH = ("neo4j", "password")
OLLAMA_MODEL = "qwen2.5-coder:14b-instruct-q4_K_M"

def get_trace_for_route(driver, route_path):
    """
    Retrieves the execution trace starting from a specific API route.
    Returns a subgraph of functions called within 3 hops (depth), including complexity.
    """
    apoc_query = """
    MATCH (start:Function) WHERE start.route = $route
    CALL apoc.path.subgraphAll(start, {
        relationshipFilter: "CALLS>",
        minLevel: 0,
        maxLevel: 3
    })
    YIELD nodes, relationships
    UNWIND nodes as node
    RETURN collect(node) as nodes, relationships
    """

    fallback_query = """
    MATCH path = (start:Function {route: $route})-[:CALLS*0..3]->(end)
    WITH collect(distinct end) as nodes_in_path, collect(distinct relationships(path)) as rels_in_path
    UNWIND nodes_in_path as node
    RETURN collect(node) as nodes, rels_in_path as relationships
    """
    
    with driver.session() as session:
        try:
            result = session.run(apoc_query, route=route_path)
            return result.data()
        except Exception as e:
            print(f"⚠️ APOC query failed ({e}), attempting fallback...")
            result = session.run(fallback_query, route=route_path)
            return result.data()

def generate_subway_map(route, raw_trace_data):
    """
    Uses the LLM to convert a list of function names and complexity scores into a User Journey.
    """
    # 1. Flatten the graph data into a text list for the prompt
    # Now including complexity!
    function_details = []
    for n in raw_trace_data['nodes']:
        # n is a Neo4j Node object, access properties with []
        props = dict(n.items())
        name = props.get('name', 'Unknown')
        complexity = props.get('complexity', 0)
        function_details.append({'name': name, 'complexity': complexity})

    system_prompt = """
    You are a Product Manager visualizing a legacy codebase.
    Your goal is to convert a raw list of Python function calls into a high-level "Subway Map" User Journey.
    
    RULES:
    1. Group related functions into "Stations" (e.g., 'validate_email', 'check_password' -> 'Login Station').
    2. The map must be linear or slightly branching (max 5-7 stations).
    3. Identify "Friction Points": A function with complexity > 50 is a major "Friction Point". A function with complexity > 20 is a potential risk.
    4. Base the 'status' and 'risk_reason' on the complexity scores provided.
    
    Input will be a JSON list of objects, each with 'name' and 'complexity'.

    Output JSON format:
    {
      "journey_name": "User Checkout Flow",
      "stations": [
        {"name": "Cart Review", "functions": ["get_cart", "calc_total"], "status": "OK", "avg_complexity": 15},
        {"name": "Payment", "functions": ["stripe_charge", "handle_payment_error"], "status": "RISK", "risk_reason": "High complexity in handle_payment_error (65)", "avg_complexity": 40}
      ]
    }
    """

    user_content = f"Route: {route}\nRaw Function Trace with Complexity: {json.dumps(function_details)}"

    response = ollama.chat(
        model=OLLAMA_MODEL,
        messages=[
            {'role': 'system', 'content': system_prompt},
            {'role': 'user', 'content': user_content}
        ],
        format='json'
    )
    return json.loads(response['message']['content'])

def render_ascii_subway_map(journey_json):
    print(f"\n🚇 SUBWAY MAP: {journey_json['journey_name']}")
    print("START " + "=" * 50 + " END")
    
    stations = journey_json['stations']
    
    # Print the Line
    line_visual = ""
    for station in stations:
        # Use avg_complexity for color coding in ASCII
        avg_complexity = station.get('avg_complexity', 0)
        symbol = "O" # Green
        if avg_complexity > 50:
            symbol = "X" # Red
        elif avg_complexity > 20:
            symbol = "!" # Yellow
            
        if station['status'] == 'RISK' and symbol != 'X':
             symbol = "X" # Ensure LLM-flagged risks are also Red

        line_visual += f"---[{symbol}]---"
    print(line_visual)
    
    # Print the Labels
    for i, station in enumerate(stations):
        avg_complexity = station.get('avg_complexity', 0)
        status_icon = "✅" # Green
        if avg_complexity > 50:
            status_icon = "🔥" # Red
        elif avg_complexity > 20:
            status_icon = "⚠️" # Yellow

        if station['status'] == 'RISK' and status_icon != "🔥":
            status_icon = "⚠️"


        print(f"Station {i+1}: {station['name']} {status_icon}")
        if 'risk_reason' in station:
            print(f"    └── Issue: {station['risk_reason']}")
        print(f"    └── Code: {', '.join(station['functions'][:3])}...")


def render_mermaid(data):
    """
    Generates a Mermaid.js definition for the subway map.
    """
    print(f"\n🌊 MERMAID JS CODE ({data['journey_name']})")
    print("Copy the block below into Mermaid Live Editor or a Markdown file:\n")
    
    mermaid_lines = ["graph LR"]
    
    # Define Styles
    mermaid_lines.append("    classDef safe fill:#c8e6c9,stroke:#2e7d32,stroke-width:2px;")
    mermaid_lines.append("    classDef risk fill:#ffcdd2,stroke:#c62828,stroke-width:4px;")
    
    # Generate Nodes
    ids = []
    for i, station in enumerate(data['stations']):
        node_id = f"S{i+1}"
        ids.append(node_id)
        
        # Icon logic
        icon = "✅" if station['status'] == "OK" else "⚠️"
        clean_name = station['name'].replace('"', "'") # Escape quotes
        
        # Apply class based on status
        style_class = "safe" if station['status'] == "OK" else "risk"
        
        line = f'    {node_id}("{icon} {clean_name}"):::{style_class}'
        mermaid_lines.append(line)
        
        # Optional: Add click events or tooltips if using in a web app
        # mermaid_lines.append(f'    click {node_id} "Functions: {", ".join(station["functions"])}" "Tooltip"')

    # Generate Connections
    # S1 --> S2 --> S3
    if len(ids) > 1:
        connection_str = " --> ".join(ids)
        mermaid_lines.append(f"    {connection_str}")

    print("\n".join(mermaid_lines))
    print("\n" + "="*40)


def main():
    if len(sys.argv) < 2:
        print("Usage: python mapper.py <route_path> [--mermaid]")
        print("Example: python mapper.py /checkout")
        sys.exit(1)

    route = sys.argv[1]
    render_format = 'ascii'
    if len(sys.argv) > 2 and sys.argv[2] == '--mermaid':
        render_format = 'mermaid'
    
    driver = GraphDatabase.driver(NEO4J_URI, auth=NEO4J_AUTH)
    
    try:
        # 1. Get Graph Data
        print(f"🔍 Tracing route: {route} in Neo4j...")
        trace_data = get_trace_for_route(driver, route)
        
        if not trace_data or not trace_data[0]['nodes']:
            print("❌ No trace found for that route. Did you run ingest2.py on the correct folder?")
            print("   Example: python ingest2.py legacy_shop/")
            return

        raw_trace_data = trace_data[0]

        # 2. Generate Map using LLM
        journey_data = generate_subway_map(route, raw_trace_data)

        # 3. Visualize
        if render_format == 'mermaid':
            render_mermaid(journey_data)
        else:
            render_ascii_subway_map(journey_data)

    finally:
        driver.close()

if __name__ == "__main__":
    main()
