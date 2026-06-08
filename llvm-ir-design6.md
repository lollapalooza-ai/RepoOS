Epic: The 5-Track Universal Compiler (Architecture V3)
Background of final outcome of RepoOS:
1. The Math Track: (Tensors/Graphs) → Routed to torch-mlir → Vectorized C-Kernel.
2. The FSM Track: (JSON/Regex/Strings) → Routed to C++ switch blocks → LLVM FSM Kernel.
3. The Tabular Track: (ORMs/SQL) → Routed to Apache Arrow SoA → Vectorized C-Kernel.
4. The Branching Track: (Rule Engines/Fraud) → Routed to MLIR cf → Branch-Optimized C-Kernel.
5. The Crypto Track: (Security/Hashing) → Bypasses AI → Routed to Pre-compiled libsodium.

Objective: Upgrade component1_ingest.py (Call 0) to act as a Semantic Classifier, analyzing Python Abstract Syntax Trees (ASTs) to classify enterprise functions into 5 distinct computational tracks. Wire the remaining pipeline (component2, component5, component9) to execute the Poly-Kernel architecture.

Milestone 1: Call 0 - The Semantic Classifier (AST Routing)
Target File: component1_ingest.py

The Directive: We must upgrade the extract_data_intents function into a full SemanticClassifier class. It will walk the Python AST (via tree-sitter or ast) and score the function based on specific heuristics to determine its true bottleneck.

Action Item: Inject this class into component1_ingest.py and update the Neo4j process_file query to ingest the execution_track.

Python
import ast

class SemanticClassifier(ast.NodeVisitor):
    def __init__(self):
        self.scores = {"MATH": 0, "FSM": 0, "TABULAR": 0, "BRANCHING": 0, "CRYPTO": 0}
        self.crypto_keywords = {'hashlib', 'hmac', 'jwt', 'bcrypt', 'AES', 'encrypt', 'verify'}

    def visit_Call(self, node):
        if isinstance(node.func, ast.Attribute):
            # FSM Heuristics: String/Byte manipulation
            if node.func.attr in ['split', 'replace', 'encode', 'decode', 'loads']:
                self.scores["FSM"] += 5
            # Tabular/ORM Heuristics: Database queries
            elif node.func.attr in ['filter', 'all', 'query', 'execute', 'fetch']:
                self.scores["TABULAR"] += 5
        elif isinstance(node.func, ast.Name):
            # Crypto Heuristics
            if any(crypto in node.func.id.lower() for crypto in self.crypto_keywords):
                self.scores["CRYPTO"] += 100 # Auto-override
        self.generic_visit(node)

    def visit_If(self, node):
        # Branching Heuristics: High density of control flow
        self.scores["BRANCHING"] += 2
        self.generic_visit(node)

    def visit_For(self, node):
        # Math/Tabular Heuristics: Heavy looping
        self.scores["MATH"] += 1
        self.scores["TABULAR"] += 1
        self.generic_visit(node)

    def visit_BinOp(self, node):
        # Math Heuristics: Dense arithmetic
        if isinstance(node.op, (ast.Mult, ast.MatMult, ast.Add, ast.Sub)):
            self.scores["MATH"] += 2
        self.generic_visit(node)

def determine_execution_track(func_code: str) -> str:
    """Call 0: The Automated Hotspot Extractor"""
    try:
        tree = ast.parse(func_code)
        classifier = SemanticClassifier()
        classifier.visit(tree)
        
        # Win conditions
        if classifier.scores["CRYPTO"] >= 100: return "CRYPTO"
        
        # Return the track with the highest heuristic score, default to MATH
        best_track = max(classifier.scores, key=classifier.scores.get)
        return best_track if classifier.scores[best_track] > 0 else "MATH"
    except SyntaxError:
        return "FSM" # Fallback for non-standard syntax
Validation for M1: Feed a Django User.objects.filter() query, a json.loads function, and a PageRank algorithm into the Ingestor. Verify Neo4j stores the correct execution_track for each.

Milestone 2: Call 1 - The Multi-Headed AI Oracle
Target File: component2_smt.py

The Directive: The AI Oracle must route the generation prompt based on the execution_track determined by Call 0.

Action Item: Update compile_function_logic to handle all tracks.

Python
async def compile_function_logic(python_code: str, execution_track: str):
    """The Call 1 Poly-Kernel Router"""
    
    if execution_track == "MATH":
        print("[Oracle] 🧮 Math Track: Generating PyTorch/DPS Module...")
        return await generate_traceable_wrapper(python_code)
        
    elif execution_track == "FSM":
        print("[Oracle] 🧵 FSM Track: Generating C++ Byte Parser...")
        return await generate_cpp_fsm(python_code) # See previous FSM C++ prompt
        
    elif execution_track == "TABULAR":
        print("[Oracle] 🗄️ Tabular Track: Generating C++ Apache Arrow Engine...")
        prompt = f"""
        Translate this ORM logic into a Zero-Copy C++ Arrow Kernel.
        RULES:
        1. Input is a Struct-of-Arrays (e.g., `const float* prices`, `const float* weights`).
        2. Perform SIMD-friendly vector operations.
        3. Write directly to `float* out_buffer`.
        PYTHON LOGIC:
        {python_code}
        """
        return await client.aio.models.generate_content(model='gemini-2.5-flash', contents=prompt)
        
    elif execution_track == "BRANCHING":
        print("[Oracle] 🌳 Branching Track: Generating MLIR SCF Dialect...")
        prompt = f"""
        Translate this nested rule engine into MLIR Structured Control Flow (scf) and Control Flow (cf) dialects.
        RULES:
        1. Use `scf.if` and `scf.yield`.
        2. Do NOT use Python runtime dependencies.
        PYTHON LOGIC:
        {python_code}
        """
        return await client.aio.models.generate_content(model='gemini-2.5-flash', contents=prompt)
        
    elif execution_track == "CRYPTO":
        print("[Oracle] 🔐 Crypto Track: Bypassing AI. Linking Native libsodium...")
        return "USE_NATIVE_LIBSODIUM"
Validation for M2: Verify that the AI returns pure MLIR for Math/Branching, pure C++ for FSM/Tabular, and a safe static string for Crypto.

Milestone 3: The Poly-Kernel Compiler
Target File: component9_aot.py

The Directive: The AOT compiler currently assumes everything is MLIR. We must fork the compilation path: MLIR goes to torch-mlir, C++ goes straight to clang, Crypto skips compilation entirely.

Action Item: Update aot_compile_all loop.

Python
    # Inside the main loop of component9_aot.py
    for record in result:
        track = record["execution_track"]
        code_to_compile = await compile_function_logic(record["code"], track)
        
        if track == "CRYPTO":
            # Just link standard system libraries
            output_dylib = "/usr/local/lib/libsodium.dylib"
            
        elif track in ["FSM", "TABULAR"]:
            # Direct C++ to Clang compilation
            with open("temp_kernel.cpp", "w") as f:
                f.write(code_to_compile.text)
            subprocess.run(["clang++", "-O3", "-shared", "-fPIC", "-march=native", 
                            "temp_kernel.cpp", "-o", output_dylib], check=True)
            
        elif track in ["MATH", "BRANCHING"]:
            # MLIR to LLVM Compilation (Your existing V2 code)
            base_mlir = await trace_to_mlir(code_to_compile)
            transform_script = await generate_transform_script(base_mlir)
            await apply_ai_transform_and_compile(base_mlir, transform_script, output_dylib)

        # Update Neo4j Cache
        session.run("MATCH (f:Function {fqn: $fqn}) SET f.optimized_dylib_path = $path", 
                    fqn=record["fqn"], path=os.path.abspath(output_dylib))
Validation for M3: Ensure clang++ successfully emits a .dylib for a C++ string parsing algorithm without invoking torch-mlir-opt.

Milestone 4: The Universal Zero-Copy Bridge
Target File: component5_orchestrator.py

The Directive: The Orchestrator must intercept the enterprise function and convert the live Python objects into the correct Zero-Copy pointers before invoking the .dylib.

Action Item: Inject to_byte_ptr and to_arrow_ptr into the Orchestrator, and upgrade trampoline_trap to handle the execution_track.

Python
# In component5_orchestrator.py
def to_byte_ptr(python_bytes_obj):
    """Zero-Copy for FSM Track"""
    buffer = (ctypes.c_char * len(python_bytes_obj)).from_buffer_copy(python_bytes_obj)
    return ctypes.cast(buffer, ctypes.c_char_p), len(python_bytes_obj)

def to_arrow_ptr(arrow_table, column_name):
    """Zero-Copy for Tabular Track"""
    # Uses PyArrow to get the raw C-pointer of a columnar array
    chunk = arrow_table.column(column_name).chunk(0)
    buf = chunk.buffers()[1]
    return ctypes.cast(buf.address, ctypes.POINTER(ctypes.c_float))

# Inside trampoline_trap
def trampoline_trap(*args, **kwargs):
    track = record["execution_track"]
    
    if track == "CRYPTO":
        return native_libsodium_wrapper(*args)
        
    elif track == "FSM":
        byte_ptr, length = to_byte_ptr(args[0])
        out_buffer = (ctypes.c_float * 10)() # Pre-allocate output
        c_func(byte_ptr, ctypes.c_size_t(length), out_buffer)
        return list(out_buffer)
        
    elif track == "TABULAR":
        prices_ptr = to_arrow_ptr(args[0], "prices")
        weights_ptr = to_arrow_ptr(args[0], "weights")
        out_buffer = (ctypes.c_float * len(args[0]))()
        c_func(prices_ptr, weights_ptr, out_buffer)
        return list(out_buffer)
        
    else: # MATH / BRANCHING
        native_args = bridge.prep_inputs(*args, **kwargs)
        c_func(*native_args)
        return bridge.post_process(native_args[-1])
Validation for M4: 1. Pass a 50MB JSON byte string to a hijacked Python function.
2. Verify sys.getsizeof() does not spike (proving Zero-Copy).
3. Verify the C-Kernel correctly extracts the numerical values from the bytes.

Engineer's Execution Checklist
[ ] M1: Merge SemanticClassifier into component1. Verify Neo4j stores 5 distinct execution_track labels.

[ ] M2: Expand AI Oracle in component2. Verify prompts correctly instruct Gemini for C++ vs MLIR generation.

[ ] M3: Fork the compilation pipeline in component9. Verify both .cpp and .mlir files successfully compile to .dylib.

[ ] M4: Implement Arrow and Byte Pointers in component5. Prove memory stability on large payloads.

By executing these four milestones sequentially, RepoOS will instantly scale from a Graph Analytics compiler to a Drop-In Enterprise Web Server accelerator.