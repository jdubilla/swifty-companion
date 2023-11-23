//
//  OAuthManager.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 23/11/2023.
//

import Foundation

private func getValue(forKey key: String) -> String {
    guard let filePath = Bundle.main.path(forResource: "InfosAPI", ofType: "plist"),
          let plist = NSDictionary(contentsOfFile: filePath),
          let value = plist.object(forKey: key) as? String else {
        fatalError("Couldn't find key '\(key)' in 'Info'.")
    }
    return value
}

private var apiSecret: String {
    return getValue(forKey: "API_SECRET")
}

private var apiUID: String {
    return getValue(forKey: "API_UID")
}

@Observable
class OAuthManager {
    
    var isAuthenticated = false
//    var accessToken: String?
    var tokenInfos: ApiToken?

    func getToken(code: String) async {
                
        let urlString = "https://api.intra.42.fr/oauth/token"
        guard let url = URL(string: urlString) else {
            print("URL is invalid")
            return
        }
        
        let clientId = apiUID
        let clientSecret = apiSecret
        let redirectUri = "https://www.google.com/"
        
        let bodyParameters = "grant_type=authorization_code&client_id=\(clientId)&client_secret=\(clientSecret)&code=\(code)&redirect_uri=\(redirectUri)"
        
//        let bodyParameters = "grant_type=refresh_token&client_id=\(clientId)&client_secret=\(clientSecret)&refresh_token=4b1f1994590f54948ddb849a5ccc902bb3e3e1e94ae732952c4179f16e25eebe&redirect_uri=\(redirectUri)"

        guard let bodyData = bodyParameters.data(using: .utf8) else {
            print("Failed to create body data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = bodyData
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
                    
                    let decoder = JSONDecoder()
                    
                    let tokenResponse = try decoder.decode(ApiToken.self, from: data)
//                    print("Token Response")
                    print(tokenResponse)
                    
                    self.tokenInfos = tokenResponse
                    self.isAuthenticated = true
                } catch {
                    print("JSON parsing error: \(error)")
                }
            }
        }.resume()
    }
}

struct ApiToken: Decodable {
    var access_token: String
    var created_at: Int
    var expires_in: Int
    var refresh_token: String
}
