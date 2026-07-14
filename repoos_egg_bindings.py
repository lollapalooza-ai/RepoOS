# Mock bindings for the Rust 'egg' E-Graph library
# Used by component11_egraph.py

class Rewrite:
    def __init__(self, name, searcher, applier):
        self.name = name
        self.searcher = searcher
        self.applier = applier

class Runner:
    def __init__(self, rules):
        self.rules = rules
        self.expr = ""

    def add_expr(self, expr):
        self.expr = expr
        return "root_id"

    def run(self):
        pass

class Extractor:
    def __init__(self, runner, cost_function):
        self.runner = runner
        self.cost_function = cost_function

    def extract(self, root_id):
        # Return a mocked reduced cost and the original expression for now
        return (10, self.runner.expr)
