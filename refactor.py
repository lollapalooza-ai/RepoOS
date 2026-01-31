import ollama

# 1. The Prompt
user_request = "Refactor the 'ingest_file' function to add error handling."

# 2. The "Context Retrieval" (RAG)
# (In a real app, we query Neo4j here to get the function body. 
# For MVP, we'll pretend we pulled this text from the graph.)
code_context = """
def ingest_file(file_path):
    with open(file_path, 'r') as f:
        code = f.read()
    tree = parser.parse(bytes(code, "utf8"))
    # ... (rest of function)
"""

# 3. The Generation (Call Qwen via Ollama)
print("Thinking...")
response = ollama.chat(model='qwen2.5-coder:14b-instruct-q4_K_M', messages=[
  {
    'role': 'system',
    'content': 'You are a Senior Engineer. Refactor the code provided. Output only code.'
  },
  {
    'role': 'user',
    'content': f"Context:\n{code_context}\n\nTask: {user_request}"
  },
])

print("\n--- AI Proposal ---\n")
print(response['message']['content'])