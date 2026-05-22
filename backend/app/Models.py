from pydantic import BaseModel
from typing import List

class OAuthRequest(BaseModel):
    provider: str
    redirect_uri: str
    scopes: List[str]
