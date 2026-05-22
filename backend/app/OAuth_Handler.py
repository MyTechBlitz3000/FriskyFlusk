import os
import secrets
import base64
import hashlib
import requests
from urllib.parse import urlencode

# PKCE helpers
def generate_code_verifier(length: int = 128):
    return base64.urlsafe_b64encode(secrets.token_bytes(length)).rstrip(b"=").decode("utf-8")

def generate_code_challenge(verifier: str):
    digest = hashlib.sha256(verifier.encode("utf-8")).digest()
    return base64.urlsafe_b64encode(digest).rstrip(b"=").decode("utf-8")

# GitHub OAuth URLs
GITHUB_AUTHORIZE_URL = "https://github.com/login/oauth/authorize"
GITHUB_TOKEN_URL = "https://github.com/login/oauth/access_token"

def get_authorization_url(client_id: str, redirect_uri: str, scopes: list[str], code_challenge: str, state: str):
    params = {
        "client_id": client_id,
        "redirect_uri": redirect_uri,
        "scope": " ".join(scopes),
        "state": state,
        "code_challenge": code_challenge,
        "code_challenge_method": "S256",
        "allow_signup": "true"
    }
    return f"{GITHUB_AUTHORIZE_URL}?{urlencode(params)}"

def exchange_code_for_token(client_id: str, client_secret: str, code: str, redirect_uri: str, code_verifier: str):
    data = {
        "client_id": client_id,
        "client_secret": client_secret,
        "code": code,
        "redirect_uri": redirect_uri,
        "code_verifier": code_verifier
    }
    headers = {"Accept": "application/json"}
    resp = requests.post(GITHUB_TOKEN_URL, data=data, headers=headers)
    return resp.json()
