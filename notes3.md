Poke holes in this idea and suggest improvements. More clarity on what the refactoring part of RepoOS should do:
1. MCP server for AI agents to provide context. Using the neo4j+vector db setup. This is the brain.
2. When asked to implement a change, it first generates a plan in the ERD format. It will have below sections:
    a. Introduction
    b. Background
    c. Justification
    d. Existing architecture
    e. Proposed architecture
        i. System diagram
        ii. Pros of the new architecture
        iii. Cons of the new architecture (including trade-offs)
        ii. Alternate architectures
        iv. Make sure to mark which architecture is recommended by the AI
        v. Each component in the architecture should internally map to an entry in Neo4J graph to relate where the changes should exist. Goal of this: when a user ask RepoOS to implement a component from the ERD, it should know what exactly to change.
    f. Test plan
        i. How it will be tested by the AI


t 02ef73a3fb90126ce01e108e3310174b443e08e6 (HEAD -> main)
response_json = json.loads(response['message']['content'])