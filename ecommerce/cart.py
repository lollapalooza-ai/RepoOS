class Cart:
    def calculate(self, payload):
        tax = payload["tax_rate"]
        return tax * 1.0
