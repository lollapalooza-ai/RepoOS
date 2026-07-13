class RepoOSBranchingBuilder:
    def __init__(self):
        self.lines = []
    
    def emit(self, line: str):
        self.lines.append(line)
        
    def build_mlir(self):
        return "module {\n" + "\n".join(self.lines) + "\n}\n"
