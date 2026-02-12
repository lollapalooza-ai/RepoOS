import unittest
from unittest.mock import MagicMock, patch
import json
from refactor2 import _parse_and_validate_response

class TestParseAndValidateResponse(unittest.TestCase):

    @patch('refactor2._repair_llm_json_string', side_effect=lambda x: x)
    @patch('refactor2.validate_code')
    def test_valid_response(self, mock_validate_code, mock_repair_json):
        mock_validate_code.return_value = None
        # Dummy JSON string to simulate the LLM response content
        jsonStr = "'{\n  \"plan_report\": \"I modified the hello_world endpoint to generate and return a random UUID using uuid.uuid4(). The /search endpoint now requires this UUID as a parameter. I updated all callers of the /search endpoint to first call hello_world to obtain the UUID before making the search request.\",\n  \"file_changes\": {\n    \"Repo1/app.py\": \"from flask import Flask, request, jsonify\nimport time\nimport uuid\n\ndef _authenticate_user(token):\n    \"\"\"Simulates user authentication.\"\"\"\n    time.sleep(0.05) # Simulate network/DB delay\n    if token == \"valid-token\":\n        return {\"user_id\": 123, \"username\": \"testuser\"}\n    return None\n\ndef _log_search_query(user_id, query):\n    \"\"\"Simulates logging the search query.\"\"\"\n    time.sleep(0.01) # Simulate DB write\n    print(f\"User {user_id} searched for: {query}\")\n    return True\n\ndef _fetch_data_from_primary_db(query):\n    \"\"\"Simulates fetching data from a primary database.\"\"\"\n    time.sleep(0.1) # Simulate complex DB query\n    if \"expensive\" in query:\n        return [{\"id\": 1, \"name\": \"Expensive Item A\"}, {\"id\": 2, \"name\": \"Expensive Item B\"}]\n    return [{\"id\": 3, \"name\": \"Normal Item C\"}, {\"id\": 4, \"name\": \"Normal Item D\"}]\n\ndef _fetch_data_from_secondary_service(query):\n    \"\"\"Simulates calling a secondary microservice or external API.\"\"\"\n    time.sleep(0.08) # Simulate network call\n    if \"promo\" in query:\n        return [{\"promo_id\": 101, \"discount\": \"10%\"}, {\"promo_id\": 102, \"discount\": \"5%\"}]\n    return []\n\ndef _apply_business_logic_and_filter(user_id, raw_data, secondary_data, query):\n    \"\"\"Simulates complex business rules and filtering.\"\"\"\n    time.sleep(0.07) # Simulate CPU-bound operation\n    filtered_results = [item for item in raw_data if query.lower() in item['name'].lower()]\n    if secondary_data:\n        filtered_results.append({\"promotions\": secondary_data})\n    \n    # Add some personalized data based on user_id (simulated)\n    if user_id == 123:\n        filtered_results.append({\"personal_recommendation\": \"Special for you!\"})\n\n    return filtered_results\n\ndef _format_results_for_display(results):\n    \"\"\"Simulates formatting data for the frontend.\"\"\"\n    time.sleep(0.03) # Simulate data transformation\n    formatted = {\"count\": len(results), \"results\": results, \"timestamp\": time.time()}\n    return formatted\n\n@app.route('/search', methods=['GET'])\ndef search_monolith():\n    \"\"\"\n    This endpoint simulates a monolithic search API that performs\n    authentication, logging, data fetching from multiple sources,\n    applying business logic, and formatting, all within a single function.\n    \"\"\"\n    auth_token = request.headers.get('Authorization')\n    query = request.args.get('q', '')\n    uuid_param = request.args.get('uuid', '')\n\n    if not auth_token:\n        return jsonify({\"error\": \"Authorization token missing\"}), 401\n    \n    user_info = _authenticate_user(auth_token)\n    if not user_info:\n        return jsonify({\"error\": \"Invalid authorization token\"}), 403\n    \n    user_id = user_info['user_id']\n    _log_search_query(user_id, query)\n\n    # --- Start Monolithic Operations ---\n    primary_db_data = _fetch_data_from_primary_db(query)\n    secondary_service_data = _fetch_data_from_secondary_service(query)\n    \n    processed_results = _apply_business_logic_and_filter(user_id, primary_db_data, secondary_service_data, query)\n    final_output = _format_results_for_display(processed_results)\n    # --- End Monolithic Operations ---\n\n    return jsonify(final_output)\n\n@app.route('/', methods=['GET'])\ndef hello_world():\n    unique_uuid = str(uuid.uuid4())\n    return jsonify({\"uuid\": unique_uuid})\n\nif __name__ == '__main__':\n    app.run(host='0.0.0.0', port=5000, debug=True)\"\n  }\n}'"
        response = {
            'message': {
                'content': json.dumps(jsonStr)
            }
        }
        filename = 'test.py'
        attempt = 1
        
        result = _parse_and_validate_response(response, filename, attempt)
        self.assertEqual(result, None)

    @patch('refactor2._repair_llm_json_string', side_effect=lambda x: x)
    @patch('refactor2.validate_code')
    def test_invalid_code(self, mock_validate_code, mock_repair_json):
        mock_validate_code.return_value = ['Syntax error']
        response = {
            'message': {
                'content': json.dumps({
                    'plan_report': 'Test plan',
                    'file_changes': {
                        'test.py': 'print "hello"'
                    }
                })
            }
        }
        filename = 'test.py'
        attempt = 1
        
        result = _parse_and_validate_response(response, filename, attempt)
        self.assertIsNone(result)

    @patch('refactor2._repair_llm_json_string', side_effect=lambda x: x)
    def test_invalid_json(self, mock_repair_json):
        response = {
            'message': {
                'content': '{"plan_report": "Test plan", "file_changes": {"test.py": "print(\'hello\')"}'
            }
        }
        filename = 'test.py'
        attempt = 1
        
        result = _parse_and_validate_response(response, filename, attempt)
        self.assertIsNone(result)

    @patch('refactor2._repair_llm_json_string', side_effect=lambda x: x)
    @patch('refactor2.validate_code')
    def test_markdown_wrapper(self, mock_validate_code, mock_repair_json):
        mock_validate_code.return_value = None
        response = {
            'message': {
                'content': '''```json
''' + json.dumps({
                    'plan_report': 'Test plan',
                    'file_changes': {
                        'test.py': 'print("hello")'
                    }
                }) + '''
```'''
            }
        }
        filename = 'test.py'
        attempt = 1
        
        result = _parse_and_validate_response(response, filename, attempt)
        self.assertEqual(result, 'print("hello")')

    @patch('refactor2._repair_llm_json_string', side_effect=lambda x: x)
    def test_missing_file_changes(self, mock_repair_json):
        response = {
            'message': {
                'content': json.dumps({
                    'plan_report': 'Test plan'
                })
            }
        }
        filename = 'test.py'
        attempt = 1
        
        result = _parse_and_validate_response(response, filename, attempt)
        self.assertIsNone(result)

    @patch('refactor2._repair_llm_json_string', side_effect=lambda x: x)
    def test_missing_filename_in_file_changes(self, mock_repair_json):
        response = {
            'message': {
                'content': json.dumps({
                    'plan_report': 'Test plan',
                    'file_changes': {
                        'another.py': 'print("world")'
                    }
                })
            }
        }
        filename = 'test.py'
        attempt = 1
        
        result = _parse_and_validate_response(response, filename, attempt)
        self.assertIsNone(result)

if __name__ == '__main__':
    unittest.main()
