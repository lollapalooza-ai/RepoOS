# Refactoring Test Report - Suite [Number] ([Round/Context])

This report documents the results of rerunning the refactoring tests after [Context/Engineer Fixes].

| Test # | Prompt | Status | Correctness (1-5) | Summary |
|---|---|---|---|---|
| [X] | [Short Prompt Description] | [Success/Partial/Failed] | [1-5] | [Brief summary of the outcome] |

## Detailed Evaluation Logs

### Test [X]: [Title of the Refactor]
**Prompt:**
[Exact text of the prompt given to the tool]

**Tasks:**
1. [Task description from the planner]
2. [Task description from the planner]
...

**Raw LLM Plan (Segment):**
```json
{
  "tasks": [
    {
      "task": "[Example Task Name]",
      "context": { "[path/to/file.py]": ["[NodeName]"] }
    }
  ]
}
```

**Target Code (Before):**
```python
# Snippet of the original code before modification
def example_method(self):
    pass
```

**Python Error Trace:**
```text
# Exact error output from the engine (SyntaxError, LibCST error, validation errors, etc.)
# e.g., 🔄 Self-Healing Retry 1/3 due to: Verification failed...
```

**Evaluation:**
- **Task 1 ([Short Description]):** [Success/Failed]. [Detailed explanation of why].
- **Task 2 ([Short Description]):** [Success/Failed]. [Detailed explanation of why].
- **Self-Healing:** [Analysis of how the tool attempted to fix its own errors].
- **Note:** [Any additional observations, e.g., hallucinations or regressions].

---

## Overall Summary (Suite [Number])

[General narrative overview of the round's performance]

### Key Strengths:
1.  **[Strength 1]:** [Description]
2.  **[Strength 2]:** [Description]

### Key Weaknesses:
1.  **[Weakness 1]:** [Description]
2.  **[Weakness 2]:** [Description]

### Suggestions for Improvement:
- [Actionable advice for developers]
