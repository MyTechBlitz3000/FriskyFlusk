import SwiftUI
import Combine
import AuthenticationServices

class OAuthManager: ObservableObject {
    @Published var clientID = ""
    @Published var clientSecret = ""
    @Published var authURL = ""
    @Published var accessToken = ""

    private var session: ASWebAuthenticationSession?

    func generateOAuth(provider: String, redirectURI: String, scopes: [String]) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/oauth/generate") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["provider": provider, "redirect_uri": redirectURI, "scopes": scopes]
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

    func startAuthFlow(redirectURI: String, state: String) {
        guard let url = URL(string: authURL) else { return }
        session = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: redirectURI
        ) { callbackURL, error in
            guard let callbackURL else { return }
            let components = URLComponents(url: callbackURL, resolvingAgainstBaseURL: false)
            if let code = components?.queryItems?.first(where: { $0.name == "code" })?.value {
                self.exchangeToken(code: code, state: state, redirectURI: redirectURI)
            }
        }
        session?.presentationContextProvider = nil
        session?.start()
    }

    func exchangeToken(code: String, state: String, redirectURI: String) {
        guard let url = URL(string: "http://127.0.0.1:8000/api/oauth/token") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body: [String: Any] = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "code": code,
            "redirect_uri": redirectURI,
            "state": state
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                DispatchQueue.main.async {
                    self.accessToken = json["access_token"] as? String ?? ""
                }
            }
        }.resume()
    }
}
