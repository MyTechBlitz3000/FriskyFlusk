from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.oauth_generator import generate_oauth
from app.models import OAuthRequest

app = FastAPI()

# Allow frontend connections
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/api/oauth/generate")
def create_oauth(req: OAuthRequest):
    creds = generate_oauth(req.provider, req.redirect_uri, req.scopes)
    return creds
