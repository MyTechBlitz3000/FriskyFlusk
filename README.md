# FriskyFlusk

FriskyFlusk is a **realistic OAuth API generator** that creates fully functional OAuth credentials (`client_id`, `client_secret`) for multiple providers.  
It is built as a **multi-language package** with Swift (iOS/iPad), Python (backend), and JavaScript/HTML (web dashboard) for end-to-end OAuth management.

---

## Features

- Generate **unique client_id and encrypted client_secret** for multiple OAuth providers.
- Supports **Authorization Code flow**, PKCE, and Client Credentials.
- Multi-platform:
  - **SwiftUI App** for iOS/iPad
  - **Python FastAPI backend**
  - **HTML + JS web dashboard**
- Secure storage of OAuth credentials using **encryption**.
- Easy integration with any web or mobile app.

---

## Folder Structure

FriskyFlusk/
├── LICENSE
├── .gitignore
├── README.md
├── SwiftUIApp/ # Swift frontend
│ ├── Package.swift
│ └── Sources/FriskyFluskApp/
├── backend/ # Python backend
│ ├── app/
│ └── requirements.txt
├── web_dashboard/ # HTML + JS dashboard
│ ├── package.json
│ ├── index.html
│ └── main.js
└── docs/ # Optional documentation


---

## Installation

### Python Backend

```bash
cd backend
python -m venv venv
source venv/bin/activate      # Windows: venv\Scripts\activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

SwiftUI App
Open SwiftUIApp/ in Xcode 17+, build and run on iOS/iPad simulator or device.
Web DashboardThen open the browser at http://127.0.0.1:8080 (or port shown by live-server).
Usage
Use SwiftUI App or Web Dashboard to generate new OAuth credentials.
Backend will return client_id and client_secret (encrypted).
Use these credentials in your applications to perform real OAuth flows.
Security
Client secrets are encrypted before storing in the database.
OAuth credentials are never exposed in plain text in logs or frontend.
All communications with the backend should be done over HTTPS in production.
Contributing
Fork the repository
Make changes in your branch
Submit a pull request
License
This project is licensed under the MIT License – see the LICENSE file for details.
Contact
Created by Justin.
For support or questions, open an issue on GitHub.
GitHub.

---

This README gives:  

- Clear **purpose**  
- **Features** and **folder structure**  
- **Installation & usage**  
- **Security notes**  
- **Contribution & license info**  

---

