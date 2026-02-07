# test_e2e.py - "Don't bother with these, the app just works" -- Dave, probably
import unittest
import os
import json
import sqlite3

# Initialize the database before any tests run
# This will create/recreate legacy_shop.db
import db 

# Import the Flask app itself for testing
# The circular import in auth.py is handled by its try-except block
import app

class LegacyShopE2ETest(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        print("--- Setting up database for E2E tests ---")
        # Ensure a clean database for each test run
        db.init_db()
        # Set up the Flask test client to make requests without running the server
        cls.app = app.app.test_client()
        cls.app.testing = True # Enable Flask's testing mode
        print("--- Database initialized and Flask test client ready ---")

    @classmethod
    def tearDownClass(cls):
        # Clean up the database file after all tests are done
        if os.path.exists('legacy_shop.db'):
            os.remove('legacy_shop.db')
            print("--- Cleaned up legacy_shop.db after tests ---")

    def test_01_index_page(self):
        print("--- Testing index page (/) ---")
        res = self.app.get('/')
        self.assertEqual(res.status_code, 200)
        self.assertIn(b"Welcome to Legacy Shop v1.0", res.data)
        print("PASSED: Index page loads correctly.")

    def test_02_login_success(self):
        print("--- Testing login with valid credentials ---")
        # The 'admin' user with password 'password' is created by db.init_db()
        res = self.app.post('/login', data={'u': 'admin', 'p': 'password'})
        self.assertEqual(res.status_code, 200)
        data = json.loads(res.data)
        self.assertEqual(data['status'], 'success')
        self.assertIn('token', data)
        print("PASSED: Admin user can log in successfully.")

    def test_03_login_fail_bad_password(self):
        print("--- Testing login with incorrect password ---")
        res = self.app.post('/login', data={'u': 'admin', 'p': 'wrongpass'})
        self.assertEqual(res.status_code, 401)
        data = json.loads(res.data)
        self.assertEqual(data['status'], 'fail')
        print("PASSED: Login fails with incorrect password.")

    def test_04_login_fail_nonexistent_user(self):
        print("--- Testing login with nonexistent user ---")
        res = self.app.post('/login', data={'u': 'nonexistent', 'p': 'password'})
        self.assertEqual(res.status_code, 401)
        data = json.loads(res.data)
        self.assertEqual(data['status'], 'fail')
        print("PASSED: Login fails for a nonexistent user.")

    def test_05_checkout_success_and_inventory_update(self):
        print("--- Testing successful checkout and inventory update ---")
        sample_cart = [
            {'id': 1, 'price': 1200.00, 'qty': 1}, # Super Gaming Laptop (initial stock: 5)
            {'id': 2, 'price': 150.00, 'qty': 2}   # Mechanical Keyboard (initial stock: 20)
        ]
        payload = {
            'cart': sample_cart,
            'user_id': 'dave' # 'dave' user created in db.init_db
        }
        res = self.app.post('/checkout', json=payload)
        self.assertEqual(res.status_code, 200)
        data = json.loads(res.data)
        self.assertEqual(data['status'], 'paid')
        self.assertIn('amt', data)
        
        # Verify that product stocks have been updated in the database
        conn = sqlite3.connect('legacy_shop.db')
        c = conn.cursor()
        c.execute("SELECT stock FROM products WHERE id = 1")
        laptop_stock = c.fetchone()[0]
        c.execute("SELECT stock FROM products WHERE id = 2")
        keyboard_stock = c.fetchone()[0]
        conn.close()

        self.assertEqual(laptop_stock, 4) # Expected: 5 - 1 = 4
        self.assertEqual(keyboard_stock, 18) # Expected: 20 - 2 = 18
        print("PASSED: Checkout successful and inventory updated correctly.")

    def test_06_admin_users_endpoint(self):
        print("--- Testing admin users endpoint (/admin/users) ---")
        # This endpoint is intentionally unauthenticated as per the problem description
        res = self.app.get('/admin/users')
        self.assertEqual(res.status_code, 200)
        data = json.loads(res.data)
        self.assertIsInstance(data, list)
        self.assertGreaterEqual(len(data), 2) # Should contain 'admin' and 'dave'
        # Example of checking content (optional, but good for E2E)
        usernames = [user[1] for user in data] # user[1] is the username column
        self.assertIn('admin', usernames)
        self.assertIn('dave', usernames)
        print("PASSED: Admin users endpoint returns user list.")

if __name__ == '__main__':
    unittest.main()
