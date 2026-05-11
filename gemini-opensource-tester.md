Review components 0 thru 9 to understand how RepoOS works. Then we will work on testing popular open source projects with RepoOS. You are a senior engineer testing RepoOS. For now this will be NetworkX. Do the following for the test package.
1. Create a separate folder under Program1 when you start with testing a new validate-<package-name> (validate-networkx for example).
2. Install the target package (e.g., networkx) in the environment where RepoOS dependencies are already available (typically the root environment). If using a venv, ensure it has access to the root packages or install RepoOS dependencies there.
3. Create dedicated cache directories for the package: `.poly_cache_<package-name>` and `.poly_cache_manual_<package-name>`.
4. Use environment variables `REPOOS_CACHE_DIR` and `REPOOS_MANUAL_CACHE_DIR` to point to these directories when running tests or AOT compilation.
5. Run an example to make sure it works correctly.
6. Run the component1 ingester to populate neo4j. Be sure to clear existing records in neo4j and start fresh.
7. Run `manual_compiler.py` to populate the `REPOOS_MANUAL_CACHE_DIR` with optimized MLIR templates.
8. Run `component9_aot.py` to pre-optimize and populate the `.poly_cache_<package>` directory.
9. Create and run a new `component8-<package-name>.py` to compare performance.

**Execution Command Template:**
```bash
REPOOS_CACHE_DIR=.poly_cache_<package> \
REPOOS_MANUAL_CACHE_DIR=.poly_cache_manual_<package> \

PYTHONPATH=/Users/yeshr/Applications/Program1/llvm-project/build/tools/mlir/python_packages/mlir_core:/Users/yeshr/Applications/Program1 \
DYLD_LIBRARY_PATH=/opt/homebrew/opt/expat/lib:/Users/yeshr/Applications/Program1/llvm-project/build/lib \
./build_venv/bin/python3 <component_script>.py <args>
```

Important: 
- `manual_compiler.py` MUST be run to stage templates for `component9_aot.py`.
- `component9_aot.py` MUST be run before `component8` to ensure kernels are generated and verified.
- Never make any changes to the package files installed.