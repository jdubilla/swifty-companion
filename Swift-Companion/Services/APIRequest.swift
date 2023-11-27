//
//  API.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 15/11/2023.
//

import Foundation

@Observable
class APIRequest {
    
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

        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())")!
        
        var request = URLRequest(url: url)

        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        let currUser = try decoder.decode(User.self, from: data)

        return currUser
    }
    
    func coalitionsData(username: String) async throws -> [Coalition]? {
        
        print("1")
        print(username)
        print(token.access_token)
        print("2")
        
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())/coalitions")!
        
        var request = URLRequest(url: url)

            request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        
        var coaUser = try decoder.decode([Coalition].self, from: data)
        
        let elementsToMove = coaUser.filter { [45, 46, 47, 48].contains($0.id) }
        coaUser = coaUser.filter { ![45, 46, 47, 48].contains($0.id) }
        coaUser.append(contentsOf: elementsToMove)
        
        return coaUser
    }
    
    func locationsUser(username: String) async throws -> [Location] {
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())/locations")!
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let locations = try decoder.decode([Location].self, from: data)
        
        return locations
    }
    
    func fetchDataUser(username: String) async {
        do {
            isFinish = false
            self.user = try await userData(username: username)
            self.coalitions = try await coalitionsData(username: username)
            try await Task.sleep(nanoseconds: 1_000_000_000)
            self.locations = try await locationsUser(username: username)
            isFinish = true
        } catch {
            self.user = nil
            print("Error: User not found")
        }
    }
}
