import SwiftUI

struct ContentView: View {
    @StateObject var oauthManager = OAuthManager()
    @State private var provider = "github"
    @State private var redirectURI = "myapp://callback"
    @State private var scopes = "repo,user"

    var body: some View {
        VStack(spacing: 20) {
            TextField("Provider", text: $provider).textFieldStyle(.roundedBorder)
            TextField("Redirect URI", text: $redirectURI).textFieldStyle(.roundedBorder)
            TextField("Scopes (comma)", text: $scopes).textFieldStyle(.roundedBorder)
            
            Button("Generate OAuth") {
                let scopeArray = scopes.split(separator: ",").map { String($0) }
                oauthManager.generateOAuth(provider: provider, redirectURI: redirectURI, scopes: scopeArray)
            }
            
            Text("Client ID: \(oauthManager.clientID)")
            Text("Client Secret: \(oauthManager.clientSecret)")
        }
        .padding()
    }
}
