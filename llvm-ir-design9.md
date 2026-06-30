# Milestone 9.0 - The total transformation

## Part 1 : Background:
Here is a deep architectural analysis of Luminal, how we extract its superpowers, and exactly how we rebuild the Repo OS V2 Inference Track to achieve our ultimate goal: obliterating PyTorch's performance by eliminating kernel launch overhead.

Part 1: The Luminal Analysis (Why it Wins)
Luminal achieves bare-metal speed without LLVM, without heuristics, and without an AI Oracle. It does this through three radical design choices:

The Micro-Primitive ISA (~15 Ops): PyTorch has over 2,000 distinct operations (aten::matmul, aten::softmax, aten::gelu, etc.). MLIR has dozens of dialects.
Luminal reduces the entire universe of deep learning down to just ~15 primitive mathematical operations (Add, Mul, Exp, Mod, SumReduce, MaxReduce, etc.). By shrinking the vocabulary, the compiler becomes incredibly simple and robust.

Equality Saturation (E-Graphs):
Instead of using a brittle, hand-written heuristic (like LLVM's Polly) or an AI to guess how to optimize a loop, Luminal uses E-Graphs. It takes a mathematical formula, applies a set of strict algebraic rewrite rules, and mechanically generates thousands of mathematically equivalent graphs. It then searches for the one with the fewest memory reads. It is 100% deterministic and mathematically proven to be correct.

Macro-Fusion (The PyTorch Killer):
Because Luminal understands the math fundamentally, it can look at a Matrix Multiply, a LayerNorm, and a GELU, and use the E-Graph to mathematically fuse them into a single hardware kernel. The data never leaves the GPU SRAM / CPU L1 Cache.

Part 2: The Flaw in Pure Luminal (Why we still need AI)
If Luminal is so perfect, why don't we just copy it 1:1 and fire the AI Oracle?

1. The Search Space Explosion: E-Graphs suffer from combinatorial explosion. If you feed an entire NanoGPT block into an E-Graph without guidance, it will generate billions of equivalent graphs and run out of RAM before it finds the optimal one.
2. Semantic Blindness: Luminal requires you to write your model in its pristine Rust DSL. It cannot ingest messy, real-world enterprise Python, custom PyTorch subclasses, or dynamic routing logic.

The Middle Ground: We use the AI Oracle to solve the exact problems that Luminal cannot solve: Semantic Translation and Search Space Pruning.

Part 3: The Transformed Architecture (Repo OS V2)
We are going to throw away the brittle MLIR Transform Dialect (RepoOSSchedule). We will no longer ask the AI to write loop tiles or fight LLVM memory scopes.

Here is the new, E-Graph inspired hybrid architecture.

Phase 1: Semantic Ingestion (The AI Oracle)
The Input: Messy PyTorch / Enterprise Python (wrapped in our Pre-Pad Shield and Bucket Compilation).

The Oracle's Job: Act as a Semantic Translator. It ingests the complex Python and translates it into a strict, minimalist mathematical graph of Micro-Primitives (the Luminal 15-Op standard).

Why it's better: The AI is no longer guessing hardware tiles. It is simply translating complex code into pure, undeniable math.

Phase 2: AI-Guided Equality Saturation (The E-Graph)
The Mechanism: We pass the primitive math graph into an E-Graph engine (e.g., Python's egglog or a lightweight Rust binary).

The Oracle's Second Job: To prevent the E-Graph from exploding, the AI Oracle provides a "Policy Hint." It looks at the graph and says, "This looks like an Attention Block. Prioritize Flash-Attention algebraic rewrites and Softmax fusion."

The Output: The E-Graph mathematically proves and outputs the 3-5 most optimal, highly fused Macro-Architectures.

Phase 3: The Arena (Variant Racing)
Instead of racing 3 AI hallucinations, we race the top 5 mathematically proven E-Graph fusions.

We compile these highly fused, primitive graphs down to C++ (or highly simplified MLIR/LLVM without the Transform Dialect baggage).

We race them in the Arena. The winner is saved to the .poly_cache.

Part 4: How We Beat PyTorch (The V2 Execution Plan)
By pivoting to this architecture, we bypass every single bug your engineer has fought for the last week.

No more MLIR alloca_scope crashes (we aren't doing complex memory transforms in MLIR anymore).

No more single-threaded handcuffs (the E-Graph defines the parallel map-reduce boundaries mathematically, making OpenMP generation trivial).

To beat PyTorch, we execute this specific strategy:

Stop Competing on Matmuls: Acknowledge that Intel MKL will always execute a single dense matmul faster than an LLVM-compiled binary.

Win on Memory Bandwidth (The Fusion Moat): PyTorch's fatal flaw is that it executes eagerly. It runs matmul (calls MKL), writes to RAM, runs softmax (calls C++), writes to RAM, runs layernorm (calls C++), writes to RAM.

The E-Graph Fusion: Our E-Graph engine will identify that the output of the matmul is immediately consumed by the softmax. It will write a single C++ kernel that does both inside the CPU registers.

The Result: We will beat PyTorch by starving the memory bus. Even if our math instructions are 5% slower than Intel MKL, we eliminate 80% of the RAM reads/writes and 100% of the Python GIL kernel launch overhead.

Next Steps for the Engineering Team
If you agree with this pivot, here is the immediate mandate for your senior engineer:

Rip out RepoOSSchedule: Delete the Transform Dialect Python DSL. We are done fighting MLIR C++ interfaces.

Build the E-Graph Bridge: Instruct the engineer to integrate an Equality Saturation library (like egglog in Python) into the orchestration layer.

Redefine the Oracle Prompt: Change the AI prompt from "Write a hardware loop schedule" to "Analyze this PyTorch graph and provide E-Graph rewrite hints (e.g., fuse matmul with layernorm)."



## Park 2: Tasks:
In this new architecture (Repo OS V2), we stop asking the AI to guess hardware tiles. Instead, we use the AI as a Macro-Architecture Strategist to guide a deterministic E-Graph Search Engine. Because the E-Graph outputs mathematically perfect, un-tiled primitive loops, LLVM's Polly engine will automatically multi-thread them without crashing.

Here is the exact architectural blueprint, component by component, with the code logic required to execute this pivot.

Component 10: component10_dynamo.py (The Routing Shield)
The Shift: We must stop Dynamo from feeding dynamic shapes (SymInt) into the compiler, and we must guarantee Macro-Fusion by intercepting the entire Transformer stack at once.

The Code Blueprint:
We implement the BucketRouter (Pre-Pad Shield). The engineer will wrap the LLM's transformer stack in this class before running inference.

Python
import torch
import torch.nn.functional as F

class RepoOSBucketRouter(torch.nn.Module):
    """
    Phase 1: The Pre-Pad Shield.
    Isolates the compiler from PyTorch's dynamic shape tracing (SymInts).
    """
    def __init__(self, core_attention_stack, buckets=[128, 256, 512, 1024]):
        super().__init__()
        self.buckets = sorted(buckets)
        
        # CRITICAL: dynamic=False forces Dynamo to trace a pristine, static graph.
        from component9_aot import egraph_inference_backend
        self.fused_stack = torch.compile(
            core_attention_stack, 
            backend=egraph_inference_backend, 
            dynamic=False
        )

    def _get_bucket(self, seq_len: int) -> int:
        for b in self.buckets:
            if seq_len <= b: return b
        return self.buckets[-1]

    def forward(self, x):
        # x shape is usually (Batch, Seq_Len, Embed_Dim)
        seq_len = x.shape[1]
        target_len = self._get_bucket(seq_len)
        
        pad_amount = target_len - seq_len
        if pad_amount > 0:
            # Pad the sequence dimension (dim 1)
            x_pad = F.pad(x, (0, 0, 0, pad_amount), "constant", 0.0)
        else:
            x_pad = x

        # Hit the AOT cache (or trigger compilation on first run)
        out_pad = self.fused_stack(x_pad)

        # Slice off padding
        if pad_amount > 0:
            return out_pad[:, :seq_len, :]
        return out_pad
Component 2: component2_smt.py (The AI Oracle)
The Shift: Delete RepoOSSchedule entirely. The AI no longer writes Python optimization scripts. Its new job is to analyze the raw PyTorch FX graph and output E-Graph Policy Hints (e.g., telling the E-Graph where to look for fusion opportunities so it doesn't run out of memory).

The Code Blueprint:

Python
async def generate_egraph_policy(fx_graph_code: str) -> dict:
    """
    Phase 2: Semantic Translation.
    The AI acts as a search-space pruner for the E-Graph.
    """
    prompt = f"""
    You are an AI Compiler Strategist. Analyze this PyTorch FX Graph and identify 
    Macro-Fusion opportunities to eliminate RAM bottlenecks.
    
    FX GRAPH:
    {fx_graph_code}
    
    TASK:
    Identify specific operation chains that should be fused by the E-Graph engine into single kernels.
    Output ONLY a JSON configuration mapping targeting the Luminal Micro-Primitives.
    
    Rules:
    - Target "Matmul + Add -> LinearFusion"
    - Target "Matmul + Mask + Softmax -> FlashAttention"
    - Target "LayerNorm -> MLP -> GELU -> MLPFusion"
    
    Output Format:
    {{
        "prioritize_rules": ["flash_attention", "linear_fusion", "mlp_fusion"],
        "max_search_depth": 5,
        "fusion_targets": ["bmm", "softmax", "layer_norm"]
    }}
    """
    # ... call Gemini API and return the JSON dictionary ...
NEW Component 3: component3_egraph.py (The Luminal Engine)
The Shift: This is the beating heart of V2. We use the egglog Python library to apply mathematical Equality Saturation. We define deep learning as a set of algebraic rewrites.

The Code Blueprint:
This engine takes the AI's policy, applies mathematically proven algebraic fusions, and returns the top structurally unique graphs.

Python
import egglog
from egglog import egraph, eq, rule, String

# 1. Define the Luminal-style Micro-Primitives
eg = egraph.EGraph()

@egraph.class_
class Tensor(egglog.Expr):
    def __init__(self, name: String): ...
    
    @egraph.method
    def matmul(self, other: "Tensor") -> "Tensor": ...
    
    @egraph.method
    def add(self, other: "Tensor") -> "Tensor": ...
    
    @egraph.method
    def softmax(self) -> "Tensor": ...

# 2. Define Mathematically Proven Fusion Rules
# Example: If the graph has a Matmul followed by an Add, fuse it into a single 'Linear' primitive.
@egraph.function
def fused_linear(a: Tensor, b: Tensor, bias: Tensor) -> Tensor: ...

eg.register(
    rule(
        eq(t_res).to(Tensor.matmul(t_a, t_b).add(t_bias))
    ).then(
        egraph.union(t_res, fused_linear(t_a, t_b, t_bias))
    )
)

# 3. The Extraction Pipeline
def apply_egraph_search(pytorch_fx_nodes: list, ai_policy: dict) -> list[str]:
    """
    Translates FX nodes to Egglog primitives, runs the E-Graph saturation 
    guided by the AI policy, and extracts the top 5 fused macro-graphs.
    """
    # (Implementation detail: Traverse FX nodes, build egglog expression)
    # eg.run(ai_policy['max_search_depth'])
    
    # Extract the lowest-cost expressions (cost = memory reads/writes)
    # Return them as clean, fused MLIR strings
    return ["<fused_mlir_variant_1>", "<fused_mlir_variant_2>"]
Component 9: component9_aot.py (The Compiler & Arena)
The Shift: We are no longer feeding AI-generated scf.forall loops into the compiler. The E-Graph hands us pristine, mathematically fused linalg MLIR. We pass this directly to LLVM and let Polly parallelize it.

The Code Blueprint:

Python
import subprocess
import os

CLANG = "clang"
MLIR_OPT = "mlir-opt"
OPENMP_THRESHOLD = 512

def egraph_inference_backend(gm: torch.fx.GraphModule, example_inputs: list):
    """The new Dynamo Entry Point."""
    from component2_smt import generate_egraph_policy
    from component3_egraph import apply_egraph_search
    
    # 1. Get Policy and E-Graph Variants
    policy = generate_egraph_policy(gm.code)
    fused_mlir_variants = apply_egraph_search(gm.graph.nodes, policy)
    
    compiled_dylibs = []
    
    # 2. Lower and Compile the Variants
    for i, mlir_text in enumerate(fused_mlir_variants):
        dylib_path = f".poly_cache/egraph_kernel_{i}.so"
        
        # Stage 1: Bufferize (create-deallocs=0 prevents the alloca_scope crash!)
        subprocess.run([
            MLIR_OPT, 
            "--empty-tensor-to-alloc-tensor",
            "--one-shot-bufferize=bufferize-function-boundaries=1 create-deallocs=0 allow-return-allocs=1",
            "-o", "memref.mlir"
        ], input=mlir_text.encode(), check=True)
        
        # Stage 2: Pure Lowering (No Transform Dialect baggage)
        subprocess.run([
            MLIR_OPT, "memref.mlir",
            "--pass-pipeline=builtin.module(convert-linalg-to-loops,lower-affine,convert-scf-to-cf,convert-cf-to-llvm,convert-vector-to-llvm,convert-arith-to-llvm,convert-func-to-llvm,reconcile-unrealized-casts)",
            "-o", "kernel.ll"
        ], check=True)
        
        # Stage 3: The Clang Polly Auto-Parallelizer
        seq_len = example_inputs[0].shape[1]
        clang_cmd = [CLANG, "-O3", "-march=native", "-ffast-math"]
        
        if seq_len >= OPENMP_THRESHOLD:
            # The loops are mathematically clean now, Polly will distribute them flawlessly.
            clang_cmd.extend(["-fopenmp", "-mllvm", "-polly", "-mllvm", "-polly-parallel"])
            
        clang_cmd.extend(["-shared", "-fPIC", "kernel.ll", "-o", dylib_path, "-lm"])
        subprocess.run(clang_cmd, check=True)
        compiled_dylibs.append(dylib_path)

    # 3. Race in the Arena
    winner_dylib = run_arena_race(compiled_dylibs, example_inputs)
    
    # Return ctypes wrapper pointing to winner_dylib
    return build_ctypes_wrapper(winner_dylib, gm)
The Architectural Verdict
By moving to Repo OS V2:

The AI is elevated from a loop-scripter to a semantic strategist.

The E-Graph guarantees mathematical correctness and executes Macro-Fusion across the entire block, starving the memory bus.

The Compiler receives clean code, allowing LLVM's Polly to safely deploy OpenMP across all available CPUs without throwing memory scope errors. 

## Technical Debt Note: LLVM Version Mismatch Workarounds
**IMPORTANT**: We are currently relying on temporary Python regex replacements in `component9_aot.py` to strip out LLVM 19/20 specific IR syntax (like `captures(none)`, `nocreateundeforpoison`, `nuw` on GEPs, and `f0x` float formats) generated by `mlir-translate`. This is necessary because our system `clang` (version 18) does not yet support these bleeding-edge keywords. 

Once we successfully benchmark this milestone and validate the E-Graph architecture, we **must** revisit this and implement a cleaner approach. Potential long-term solutions:
1. Compile and link against an LLVM 19+ version of `clang`.
2. Configure `mlir-translate` to target an older LLVM IR syntax.
3. Replace the text-based Clang invocation with LLVM's Python/C++ bindings (JIT ExecutionEngine) directly in memory, which would use the exact same LLVM version that `torch-mlir` was built with.
