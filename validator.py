import ast
import io
import sys
import os
import subprocess # Import subprocess for calling flake8
# from flake8.api import legacy as flake8 # No longer needed for this approach
# from flake8.main import application as flake8_application # No longer needed for this approach

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
    try:
        # Use subprocess to call flake8 on the code string passed via stdin
        # --exit-zero: always exit with 0 even if errors are found, so we check stdout/stderr
        # --isolated: Don't load any config files, use only command line options
        # --stdin-display-filename: Use a consistent filename in error reports
        flake8_command = [
            sys.executable, "-m", "flake8", 
            "--exit-zero", 
            "--isolated", 
            "--stdin-display-filename", "temp_code_to_validate.py",
            "-" # Tells flake8 to read from stdin
        ]
        
        process = subprocess.run(
            flake8_command,
            input=code_string, # Pass code string directly (text=True handles encoding)
            capture_output=True,
            text=True, # Decode stdout/stderr as text
            check=False # Don't raise an exception for non-zero exit codes
        )

        output = process.stdout # Flake8 writes errors to stdout by default
        
        if output: # If there's any output, it means there are errors
            for line in output.strip().splitlines():
                # Flake8 output format: 'filename:line:col: CODE message'
                parts = line.split(':')
                if len(parts) >= 4:
                    # Adjusting the filename part as it will be 'temp_code_to_validate.py'
                    error_line = parts[1].strip()
                    error_code = parts[3].strip()
                    error_message = ":".join(parts[4:]).strip()
                    errors.append(f"Linting Error on line {error_line}: [{error_code}] {error_message}")
        
    except FileNotFoundError:
        errors.append("Error: flake8 command not found. Please ensure flake8 is installed and in your PATH.")
    except Exception as e:
        errors.append(f"Validator internal error during Flake8 linting: {e}")

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
