import SwiftUI
import Combine

// MARK: - OAuth Manager
class OAuthManager: ObservableObject {
    @Published var clientID = ""
    @Published var clientSecret = ""
    @Published var authURL = ""
    @Published var accessToken = ""

    func generateOAuth(provider: String, redirectURI: String, scopes: [String]) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/oauth/generate") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "provider": provider,
            "redirect_uri": redirectURI,
            "scopes": scopes
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                DispatchQueue.main.async {
                    self.clientID = json["client_id"] as? String ?? ""
                    self.clientSecret = json["client_secret"] as? String ?? ""
                    self.authURL = json["auth_url"] as? String ?? ""
                }
            }
        }.resume()
    }
}

// MARK: - Content View
struct ContentView: View {
    @StateObject var oauthManager = OAuthManager()
    @State private var provider = "github"
    @State private var redirectURI = "myapp://callback"
    @State private var scopes = "repo,user"

    var body: some View {
        VStack(spacing: 20) {
            TextField("Provider", text: $provider)
                .textFieldStyle(.roundedBorder)
            TextField("Redirect URI", text: $redirectURI)
                .textFieldStyle(.roundedBorder)
            TextField("Scopes (comma)", text: $scopes)
                .textFieldStyle(.roundedBorder)
            
            Button("Generate OAuth") {
                let scopeArray = scopes.split(separator: ",").map { String($0) }
                oauthManager.generateOAuth(provider: provider, redirectURI: redirectURI, scopes: scopeArray)
            }
            
            Text("Client ID: \(oauthManager.clientID)")
            Text("Client Secret: \(oauthManager.clientSecret)")
            Text("Auth URL: \(oauthManager.authURL)")
                .foregroundColor(.blue)
                .underline()
        }
        .padding()
    }
}

// MARK: - App Entry Point
@main
struct FriskyFluskApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
