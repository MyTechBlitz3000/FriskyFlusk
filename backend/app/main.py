from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from app.oauth_generator import generate_oauth
from app.models import OAuthRequest
from app.oauth_handler import generate_code_verifier, generate_code_challenge, get_authorization_url, exchange_code_for_token
import secrets

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Store verifier temporarily (in memory for demo)
code_verifiers = {}

@app.post("/api/oauth/generate")
def create_oauth(req: OAuthRequest):
    creds = generate_oauth(req.provider, req.redirect_uri, req.scopes)
    # Generate PKCE verifier & challenge
    code_verifier = generate_code_verifier()
    code_challenge = generate_code_challenge(code_verifier)
    state = secrets.token_urlsafe(16)
    
    # Store code_verifier using state
    code_verifiers[state] = code_verifier

    # Authorization URL
    auth_url = get_authorization_url(
        client_id=creds["client_id"],
        redirect_uri=creds["redirect_uri"],
        scopes=creds["scopes"],
        code_challenge=code_challenge,
        state=state
    )

    return {
        **creds,
        "auth_url": auth_url,
        "state": state
    }

@app.post("/api/oauth/token")
def get_token(client_id: str, client_secret: str, code: str, redirect_uri: str, state: str):
    if state not in code_verifiers:
        raise HTTPException(status_code=400, detail="Invalid state")
    code_verifier = code_verifiers.pop(state)
    token_response = exchange_code_for_token(client_id, client_secret, code, redirect_uri, code_verifier)
    return token_response
