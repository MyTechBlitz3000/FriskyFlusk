import uuid
from cryptography.fernet import Fernet

# Generate a key for encryption (in real use, store securely)
key = Fernet.generate_key()
cipher = Fernet(key)

def generate_oauth(provider: str, redirect_uri: str, scopes: list[str]):
    client_id = str(uuid.uuid4())
    client_secret_bytes = uuid.uuid4().bytes
    client_secret = cipher.encrypt(client_secret_bytes).hex()
    
    return {
        "provider": provider,
        "client_id": client_id,
        "client_secret": client_secret,
        "redirect_uri": redirect_uri,
        "scopes": scopes
    }
