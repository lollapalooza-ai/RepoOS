import ast
import io
import sys
from flake8.api import legacy as flake8

def validate_code(code_string: str) -> list:
    """
    Validates a string of Python code using AST parsing and Flake8 linting.

    Args:
        code_string: The Python code to validate.

    Returns:
        A list of error messages. An empty list means the code is valid.
    """
    errors = []

    # 1. AST Parsing for basic syntax validity
    try:
        ast.parse(code_string)
    except SyntaxError as e:
        # Provide a more specific error message for the LLM
        errors.append(f"Fatal SyntaxError on line {e.lineno}: {e.msg}. The Python interpreter cannot parse this code.")
        # No point in linting if syntax is fundamentally broken
        return errors

    # 2. Flake8 Linting for style and common errors
    # We use a custom stdout capture to get flake8's report as a string
    # since the legacy API prints directly to stdout.
    old_stdout = sys.stdout
    sys.stdout = captured_output = io.StringIO()

    # Create a StyleGuide and run checks on the code string
    style_guide = flake8.StyleGuide(quiet=False, show_source=True)
    report = style_guide.check_application(code=code_string)

    # Restore stdout
    sys.stdout = old_stdout
    output = captured_output.getvalue()

    # Process the report if there are errors
    if report.total_errors > 0:
        # We process the raw output string from flake8
        lines = output.strip().splitlines()
        # The output includes the source code, followed by the errors.
        # We only need the error lines.
        error_lines = [line for line in lines if 'stdin:' in line]
        for line in error_lines:
            # Flake8 output is typically './stdin:line:col: CODE message'
            parts = line.split(':')
            if len(parts) >= 4:
                error_code = parts[3].strip()
                error_message = ":".join(parts[4:]).strip()
                errors.append(f"Linting Error on line {parts[1]}: [{error_code}] {error_message}")

    return errors

# --- Example Usage (for testing the validator itself) ---
if __name__ == '__main__':
    # Example of valid code
    valid_code = "def my_func(a, b):\n    return a + b\n"
    print(f"Validating good code:\n---\n{valid_code}\n---")
    validation_errors = validate_code(valid_code)
    if not validation_errors:
        print("✅ Code is valid.\n")
    else:
        print("❌ Found unexpected errors:")
        for err in validation_errors:
            print(f"   - {err}")
    print("-" * 20)

    # Example of invalid syntax
    invalid_syntax = "def my_func(a, b)\n    return a + b\n"
    print(f"Validating bad syntax:\n---\n{invalid_syntax}\n---")
    validation_errors = validate_code(invalid_syntax)
    if validation_errors:
        print("✅ Correctly found errors:")
        for err in validation_errors:
            print(f"   - {err}")
    else:
        print("❌ Failed to find errors.")
    print("-" * 20)

    # Example of linting error (unused import)
    linting_error = "import os\n\ndef my_func(a, b):\n    return a + b\n"
    print(f"Validating linting error:\n---\n{linting_error}\n---")
    validation_errors = validate_code(linting_error)
    if validation_errors:
        print("✅ Correctly found errors:")
        for err in validation_errors:
            print(f"   - {err}")
    else:
        print("❌ Failed to find errors.")
    print("-" * 20)
