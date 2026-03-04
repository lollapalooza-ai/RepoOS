import subprocess
import time
import os
import signal

def test():
    file_path = "Repo1/app.py"
    # Ensure clean state
    with open(file_path, "r") as f:
        original_content = f.read()

    # Start refactor2.py
    # We use a very specific prompt to target hello_world
    cmd = ["python3", "refactor2.py", "Add a unique comment to hello_world function"]
    proc = subprocess.Popen(cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1)

    print("🚀 Started refactor2.py. Waiting for prompt...")
    
    found_prompt = False
    output_log = []
    
    # Read output line by line
    start_time = time.time()
    while time.time() - start_time < 60: # 1 minute timeout
        line = proc.stdout.readline()
        if not line:
            break
        print(f"[LLM]: {line.strip()}")
        output_log.append(line)
        
        if "Apply changes for Task 1? (y/n):" in line:
            print("\n🔥 Mutation Trigger: Modifying file externally NOW...")
            with open(file_path, "a") as f:
                f.write("\n# External Mutation detected by checksum!\n")
            
            print("⌨️  Sending 'y' to process...")
            proc.stdin.write("y\n")
            proc.stdin.flush()
            found_prompt = True
            break

    if not found_prompt:
        print("\n❌ Error: Timed out waiting for prompt or process died.")
        proc.kill()
        return

    # Read remaining output
    print("⏳ Waiting for final output...")
    remaining_output, _ = proc.communicate(timeout=30)
    print(f"[LLM FINAL]: {remaining_output}")
    output_log.append(remaining_output)

    full_output = "".join(output_log)
    if "STATE_MUTATION_DETECTED" in full_output or "CRITICAL: State mismatch" in full_output:
        print("\n✅ SUCCESS: Mutation detected and refactor aborted safely.")
    else:
        print("\n❌ FAILURE: Mutation NOT detected! The file might have been corrupted.")

    # Restore original content
    with open(file_path, "w") as f:
        f.write(original_content)

if __name__ == "__main__":
    test()
