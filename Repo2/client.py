import requests
import json
import uuid

REPO1_BASE_URL = "http://127.0.0.1:5000" # Assuming Repo1 runs locally on port 5000
cached_uuid = None
def call_hello_world_api():
    global cached_uuid
    if cached_uuid is not None:
        return cached_uuid
    try:
        response = requests.get(f"{REPO1_BASE_URL}/hello_world")
        response.raise_for_status()  # Raise an HTTPError for bad responses (4xx or 500)
        cached_uuid = response.json().get('uuid')
        return cached_uuid
    except requests.exceptions.HTTPError as err:
        print(f"HTTP error occurred: {err}")  # Python 3.6+
    except requests.exceptions.ConnectionError as err:
        print(f"Error Connecting: {err}")
    except requests.exceptions.Timeout as err:
        print(f"Timeout Error: {err}")
    except requests.exceptions.RequestException as err:
        print(f"Something went wrong: {err}")
    return None

def call_search_api(query, uuid=None, token="valid-token"):
    if uuid is None:
        uuid = call_hello_world_api()
    headers = {"Authorization": token}
    params = {"q": query, "uuid": uuid}
    
    try:
        response = requests.get(f"{REPO1_BASE_URL}/search", headers=headers, params=params)
        response.raise_for_status()  # Raise an HTTPError for bad responses (4xx or 500)
        return response.json()
    except requests.exceptions.HTTPError as err:
        print(f"HTTP error occurred: {err}")  # Python 3.6+
    except requests.exceptions.ConnectionError as err:
        print(f"Error Connecting: {err}")
    except requests.exceptions.Timeout as err:
        print(f"Timeout Error: {err}")
    except requests.exceptions.RequestException as err:
        print(f"Something went wrong: {err}")
    return None

if __name__ == "__main__":
    print("Calling Repo1 hello_world API to get UUID...")
    uuid = call_hello_world_api()
    if not uuid:
        print("Failed to get UUID. Exiting.")
        exit(1)
    
    print(f"UUID obtained: {uuid}")
    
    print("Calling Repo1 search API with query 'normal'...")
    results = call_search_api("normal")
    if results:
        print(json.dumps(results, indent=2))
    else:
        print("Failed to get results.")
    
    print("Calling Repo1 search API with query 'expensive' and invalid token...")
    results_invalid_token = call_search_api("expensive", token="invalid-token")
    if results_invalid_token:
        print(json.dumps(results_invalid_token, indent=2))
    else:
        print("Failed to get results with invalid token (expected).")
    
    print("Calling Repo1 search API with query 'promo'...")
    results_promo = call_search_api("promo")
    if results_promo:
        print(json.dumps(results_promo, indent=2))
    else:
        print("Failed to get results.")