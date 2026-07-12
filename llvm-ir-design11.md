# The Validation App
## App Requirements:
1. A job that calls existing API "/api/v1/orders" in legacy_shop/api_server.py folder. The job is initated once every 30 seconds. 
2. Using the response, the job computes vip revenue (logic in calculate_vip_revenue function). 
3. Using the same response, it computes sum of revenues in each of the 3 order status categories "PROCESSED", "PENDING", "CANCELLED".
4. Writes the output from 2 and 3 into a mysql table revenue_details. Columns are id (unique random uuid), vip_revenue, processed_revenue, pending_revenue, cancelled_revenue.
3. A new api, "/api/v2/revenue" returns every row whose cancelled_revenue is over 20.