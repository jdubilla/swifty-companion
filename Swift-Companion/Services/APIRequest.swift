//
//  API.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 15/11/2023.
//

import Foundation

@Observable
class APIRequest {
    
//    var token: String
    var token: ApiToken
    var isFinish = false
    var user: User?
    var coalitions: [Coalition]?
    var locations: [Location]?
    
    init(token: ApiToken) {
        print(token.access_token)
        self.token = token
    }
    
    func userData(username: String) async throws -> User? {
//        let testUsername = "jdubilla"
//        let url = URL(string: "https://api.intra.42.fr/v2/users/\(testUsername.lowercased())")!

        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())")!
        
        var request = URLRequest(url: url)

        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        let currUser = try decoder.decode(User.self, from: data)

        return currUser
    }
    
    func coalitionsData(username: String) async throws -> [Coalition]? {
//        let testUsername = "jdubilla"
//        let url = URL(string: "https://api.intra.42.fr/v2/users/\(testUsername.lowercased())/coalitions")!
        
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())/coalitions")!
        
        var request = URLRequest(url: url)

            request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        var coaUser = try decoder.decode([Coalition].self, from: data)
        
//         45 46 47 48
        

        // Filtrer les éléments à déplacer vers la fin du tableau
        let elementsToMove = coaUser.filter { [45, 46, 47, 48].contains($0.id) }

        // Retirer les éléments du tableau
        coaUser = coaUser.filter { ![45, 46, 47, 48].contains($0.id) }

        // Ajouter les éléments à la fin du tableau
        coaUser.append(contentsOf: elementsToMove)
        
        return coaUser
    }
    
    func locationsUser(username: String) async throws -> [Location] {
//        let testUsername = "jdubilla"
//        let url = URL(string: "https://api.intra.42.fr/v2/users/\(testUsername.lowercased())/locations")!

        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())/locations")!
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
//        print(String(data: data, encoding: .utf8)!) // Affiche les données brutes
        let locations = try decoder.decode([Location].self, from: data)
//        print(locations)
        
//        print(String(data: data, encoding: .utf8)!) // Affiche les données brutes
        
//        do {
//            let locations = try decoder.decode([Location].self, from: data)
////            print(locations)
//            return locations
//        } catch {
//            print("Error decoding data: \(error)")
//            throw error
//        }
        
        return locations
    }
    
    func fetchDataUser(username: String) async {
        do {
            isFinish = false
            self.user = try await userData(username: username)
            print("1")
            self.coalitions = try await coalitionsData(username: username)
            print("2")
            try await Task.sleep(nanoseconds: 1_000_000_000) // Attente d'une seconde (en millisecondes)
            self.locations = try await locationsUser(username: username)
            print("3")
            isFinish = true
        } catch {
            self.user = nil
            print("Error: User not found")
        }
    }
}

struct Location: Decodable, Hashable {
    var begin_at: String
    var end_at: String?
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
    var cursus_id: Int
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
