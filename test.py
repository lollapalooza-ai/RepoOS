def get_user():
    return "Alice"

def process_payment():
    user = get_user()  # Dependency!
    validate_bank(user) # Dependency!

def validate_bank(u):
    print("Checking bank...")