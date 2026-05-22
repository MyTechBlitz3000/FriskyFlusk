import Foundation
import Combine

class OAuthManager: ObservableObject {
    @Published var clientID = ""
    @Published var clientSecret = ""
    @Published var authURL = ""
    @Published var accessToken = ""

    private var session: Any? = nil

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
