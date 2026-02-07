# db.py - "I'll switch to Postgres later" -- Dave, 2014
import sqlite3
import hashlib
import os

DB_NAME = "legacy_shop.db"

def get_connection():
    # Dave: context managers are confusing, just return the conn
    return sqlite3.connect(DB_NAME)

def init_db():
    print("Initializing Database... (Hope you backed up your data!)")
    
    if os.path.exists(DB_NAME):
        os.remove(DB_NAME) # Yikes
        
    conn = get_connection()
    c = conn.cursor()
    
    # 1. Users Table (Plaintext? No, we use MD5. Secure!)
    # Password is 'password' -> '5f4dcc3b5aa765d61d8327deb882cf99'
    c.execute('''
        CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL,
            password_hash TEXT NOT NULL,
            email TEXT
        )
    ''')
    
    admin_pass = hashlib.md5("password".encode()).hexdigest()
    c.execute(f"INSERT INTO users (username, password_hash, email) VALUES ('admin', '{admin_pass}', 'admin @legacyshop.com')")
    c.execute(f"INSERT INTO users (username, password_hash, email) VALUES ('dave', '{admin_pass}', 'dave @legacyshop.com')")

    # 2. Products Table
    c.execute('''
        CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            price REAL NOT NULL,
            stock INTEGER DEFAULT 100
        )
    ''')
    
    # Seeding data for the checkout test
    products = [
        ('Super Gaming Laptop', 1200.00, 5),
        ('Mechanical Keyboard', 150.00, 20),
        ('Mouse Pad', 15.00, 500)
    ]
    
    c.executemany("INSERT INTO products (name, price, stock) VALUES (?, ?, ?)", products)
    
    conn.commit()
    conn.close()
    print("Database seeded successfully. Admin user created.")

def run_raw_sql(sql_string):
    # GENERIC HELPER - DANGEROUS
    # Any file importing this can drop tables if they want.
    conn = get_connection()
    c = conn.cursor()
    try:
        c.execute(sql_string)
        conn.commit()
        return c.fetchall()
    except Exception as e:
        print("SQL Error: " + str(e))
        return None
    finally:
        conn.close()

if __name__ == "__main__":
    # You have to run 'python db.py' first to make the app work
    init_db()