from flask import Flask, request, jsonify
import time
import uuid

def _authenticate_user(token):
    """Simulates user authentication."""
    time.sleep(0.05) # Simulate network/DB delay
    if token == "valid-token":
        return {"user_id": 123, "username": "testuser"}
    return None

def _log_search_query(user_id, query):
    """Simulates logging the search query."""
    time.sleep(0.01) # Simulate DB write
    print(f"User {user_id} searched for: {query}")
    return True

def _fetch_data_from_primary_db(query):
    """Simulates fetching data from a primary database."""
    time.sleep(0.1) # Simulate complex DB query
    if "expensive" in query:
        return [{"id": 1, "name": "Expensive Item A"}, {"id": 2, "name": "Expensive Item B"}]
    return [{"id": 3, "name": "Normal Item C"}, {"id": 4, "name": "Normal Item D"}]

def _fetch_data_from_secondary_service(query):
    """Simulates calling a secondary microservice or external API."""
    time.sleep(0.08) # Simulate network call
    if "promo" in query:
        return [{"promo_id": 101, "discount": "10%"}, {"promo_id": 102, "discount": "5%"}]
    return []

def _apply_business_logic_and_filter(user_id, raw_data, secondary_data, query):
    """Simulates complex business rules and filtering."""
    time.sleep(0.07) # Simulate CPU-bound operation
    filtered_results = [item for item in raw_data if query.lower() in item['name'].lower()]
    if secondary_data:
        filtered_results.append({"promotions": secondary_data})
    
    # Add some personalized data based on user_id (simulated)
    if user_id == 123:
        filtered_results.append({"personal_recommendation": "Special for you!"})

    return filtered_results

def _format_results_for_display(results):
    """Simulates formatting data for the frontend."""
    time.sleep(0.03) # Simulate data transformation
    formatted = {"count": len(results), "results": results, "timestamp": time.time()}
    return formatted

@app.route('/search', methods=['GET'])
def search_monolith():
    """
    This endpoint simulates a monolithic search API that performs
    authentication, logging, data fetching from multiple sources,
    applying business logic, and formatting, all within a single function.
    """
    auth_token = request.headers.get('Authorization')
    query = request.args.get('q', '')
    uuid_param = request.args.get('uuid', '')

    if not auth_token:
        return jsonify({"error": "Authorization token missing"}), 401
    
    user_info = _authenticate_user(auth_token)
    if not user_info:
        return jsonify({"error": "Invalid authorization token"}), 403
    
    user_id = user_info['user_id']
    _log_search_query(user_id, query)

    # --- Start Monolithic Operations ---
    primary_db_data = _fetch_data_from_primary_db(query)
    secondary_service_data = _fetch_data_from_secondary_service(query)
    
    processed_results = _apply_business_logic_and_filter(user_id, primary_db_data, secondary_service_data, query)
    final_output = _format_results_for_display(processed_results)
    # --- End Monolithic Operations ---

    return jsonify(final_output)

@app.route('/', methods=['GET'])
def hello_world():
    unique_uuid = str(uuid.uuid4())
    return jsonify({"uuid": unique_uuid})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)