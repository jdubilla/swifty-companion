//
//  API.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 15/11/2023.
//

import Foundation

@Observable
class APIRequest {
    
    var token: String
    var isFinish = false
    var user: User?
    var coalitions: [Coalition]?
    var locations: [Location]?
    
    init(token: String) {
        self.token = token
    }


//    func fetchToken() {
//        let url = URL(string: "https://api.intra.42.fr/oauth/token")!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        
//        let grantType = "client_credentials"
//        let bodyString = "grant_type=\(grantType)&client_id=\(apiUID)&client_secret=\(apiSecret)"
//        request.httpBody = bodyString.data(using: .utf8)
//        
//        
//        let session = URLSession(configuration: .default)
//        
//        let task = session.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                return
//            }
//            
//            guard let responseJson = try? JSONDecoder().decode(TokenResponse.self, from: data) else {
//                return
//            }
//            print(responseJson)
//            self.token = responseJson
//        }
//        
//        task.resume()
//    }
    
//    func checkAndFetchTokenIfNeeded() {
//        print("Check Token")
//        if self.token == nil || shouldRefreshToken() {
//            self.fetchToken()
//        }
//    }
    
//    func shouldRefreshToken() -> Bool {
//        let timestamp = Int(Date().timeIntervalSince1970)
//        
//        if let expiration = self.token?.created_at, let created_at = self.token?.created_at, (created_at + expiration + 10) < timestamp {
//            return true
//        }
//        return false
//    }
    
    func userData(username: String) async throws -> User? {
        let testUsername = "jdubilla"
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(testUsername.lowercased())")!

//        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())")!
        
        var request = URLRequest(url: url)
//        if let access_token = self.token?.access_token {
//            request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
//        }
        
//        if let access_token = self.token?.access_token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        let currUser = try decoder.decode(User.self, from: data)

        return currUser
    }
    
    func coalitionsData(username: String) async throws -> [Coalition]? {
        let testUsername = "jdubilla"
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(testUsername.lowercased())/coalitions")!
        
//        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())/coalitions")!
        
        var request = URLRequest(url: url)
//        if let access_token = self.token?.access_token {
//            request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
//        }
        
//        if let access_token = self.token?.access_token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        let currUser = try decoder.decode([Coalition].self, from: data)

        return currUser
    }
    
    func locationsUser(username: String) async throws -> [Location] {
        let testUsername = "jdubilla"
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(testUsername.lowercased())/locations")!

//        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())/locations")!
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        let locations = try decoder.decode([Location].self, from: data)
        print(locations)
        
        return locations
    }
    
    func fetchDataUser(username: String) async {
        do {
            self.user = try await userData(username: username)
            self.coalitions = try await coalitionsData(username: username)
            self.locations = try await locationsUser(username: username)
        } catch {
            self.user = nil
            print("Error: User not found")
        }
    }
}

struct Location: Decodable, Hashable {
    var begin_at: String
    var end_at: String
    var host: String
}

struct User: Decodable {
    var login, first_name, last_name, email: String
    var image: ImageUser
    var location: String?
    var wallet: Int
    var cursus_users: [CursusUser]
    var projects_users: [ProjectsUsers]
}

struct ProjectsUsers: Decodable, Identifiable {
    var id: Int
    var final_mark: Int?
    var status: String
    var project: Project
    var cursus_ids: [Int]
    var validated: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case final_mark
        case status
        case project
        case cursus_ids
        case validated = "validated?"
    }
}

struct Project: Decodable, Identifiable {
    var id: Int
    var name: String
}

struct ImageUser: Decodable {
    var link: String
}

struct CursusUser: Decodable {
    var grade: String?
    var level: Double
    var skills: [Skills]
}

struct Skills: Decodable, Hashable {
    var id: Int
    var name: String
    var level: Double
}

struct Coalition: Decodable {
    let id: Int
    let imageUrl: String
    let coverUrl: String
    let color: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image_url"
        case coverUrl = "cover_url"
        case color
    }
}
