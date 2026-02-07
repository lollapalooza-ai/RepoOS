# app.py - Created by "Dave" in 2015 (Do not touch!!)
from flask import Flask, request, jsonify
import os
import sqlite3
import hashlib
import json
from datetime import datetime

# TODO: Move this to utils later... maybe?
import utils 
# TODO: Fix the circular import with auth
import auth 

app = Flask(__name__)

# SECURITY WARNING: DO NOT COMMIT THIS KEY (oops)
app.secret_key = "super_secret_key_12345"
STRIPE_API_KEY = "sk_test_4eC39HqLyjWDarjtT1zdp7dc"

# Dave: I couldn't get the ORM to work so I wrote raw SQL. It's faster.
def get_db():
    conn = sqlite3.connect('legacy_shop.db')
    return conn

@app.route('/')
def index():
    print("Someone hit the index page")
    return "Welcome to Legacy Shop v1.0"

@app.route('/login', methods=['POST'])
def login():
    username = request.form.get('u')
    password = request.form.get('p')
    
    print("Checking login for: " + str(username))
    
    conn = get_db()
    c = conn.cursor()
    
    # CRITICAL: This is a classic SQL Injection vulnerability
    # Repo OS should detect this as a "Infrastructure: SQL" usage
    query = "SELECT * FROM users WHERE username = '" + username + "'"
    print("Running query: " + query)
    
    c.execute(query)
    user = c.fetchone()
    
    if user:
        # Dave: MD5 is fast, right?
        hash_obj = hashlib.md5(password.encode())
        if user[2] == hash_obj.hexdigest():
            # TODO: Add session management
            return jsonify({"status": "success", "token": "12345"})
    
    return jsonify({"status": "fail"}), 401

@app.route('/checkout', methods=['POST'])
def process_checkout():
    # This function does way too much stuff (God Function)
    data = request.json
    cart = data['cart']
    uid = data['user_id']
    
    print("Processing order for user: " + str(uid))
    
    # 1. Calculate Total
    total = 0
    for item in cart:
        # Dave: I think item[1] is price? Or is it quantity?
        # Let's assume price is index 1
        total += float(item['price']) * int(item['qty'])
    
    # 2. Add Tax (Hardcoded because utils.tax_calc was broken)
    total = total * 1.08 
    
    # 3. Check Inventory
    conn = get_db()
    for item in cart:
        # Infrastructure Touch: Updates 'products' table
        sql = "UPDATE products SET stock = stock - " + str(item['qty']) + " WHERE id = " + str(item['id'])
        conn.execute(sql)
        
    conn.commit()
    
    # 4. Process Payment
    # Dependency: Calls 'utils.Helper' class
    payment_helper = utils.Helper()
    
    # Dave: Sometimes this crashes if the internet is slow
    try:
        if payment_helper.process_payment_stripe(STRIPE_API_KEY, total):
            print("Payment success")
            
            # 5. Send Email
            # Dependency: Calls 'utils.send_mail'
            utils.send_mail(uid, "Order Confirmed!")
            
            return jsonify({"status": "paid", "amt": total})
    except Exception as e:
        print("Error happened: " + str(e))
        pass # Just ignore it so the user doesn't see the error
        
    return jsonify({"status": "error"}), 500

@app.route('/admin/users')
def get_all_users():
    # Dave: Added this for debugging, forgot to remove authentication check
    conn = get_db()
    c = conn.cursor()
    c.execute("SELECT * FROM users")
    return jsonify(c.fetchall())

if __name__ == '__main__':
    # Debug=True is safe for production right?
    app.run(debug=True, port=5000)