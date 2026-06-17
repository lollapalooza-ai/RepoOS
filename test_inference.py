
import torch
import user_script
from component10_dynamo import repoos_inference_backend

# Monkey patch or just call manually
if __name__ == "__main__":
    # Register the backend
    import torch._dynamo
    torch._dynamo.register_backend(repoos_inference_backend)
    
    # Run the user script's main
    user_script.main()
