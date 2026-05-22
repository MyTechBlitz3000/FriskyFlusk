async function generateOAuth() {
    const provider = document.getElementById("provider").value;
    const redirect_uri = document.getElementById("redirect_uri").value;
    const scopes = document.getElementById("scopes").value.split(',');

    const response = await fetch("http://127.0.0.1:8000/api/oauth/generate", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ provider, redirect_uri, scopes })
    });

    const data = await response.json();
    document.getElementById("result").innerText = JSON.stringify(data, null, 2);
}
