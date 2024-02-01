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
        self.token = token
    }
    
    func userData(username: String) async throws -> User? {

        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")

		guard let (data, _) = try? await URLSession.shared.data(for: request) else {
			throw NetworkError.network
		}

        let decoder = JSONDecoder()

		guard var currUser = try? decoder.decode(User.self, from: data) else {
			throw NetworkError.userNotFound
		}

        for index in 0..<currUser.achievements.count {
            currUser.achievements[index].image = currUser.achievements[index].image.replacingOccurrences(of: "/uploads", with: "https://cdn.intra.42.fr")
        }
        
        return currUser
    }
    
    func coalitionsData(username: String) async throws -> [Coalition]? {
        
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())/coalitions")!
        
        var request = URLRequest(url: url)

            request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")

		guard let (data, _) = try? await URLSession.shared.data(for: request) else {
			throw NetworkError.network
		}
        let decoder = JSONDecoder()
        
		guard var coaUser = try? decoder.decode([Coalition].self, from: data) else {
			throw NetworkError.userNotFound
		}

        let elementsToMove = coaUser.filter { [45, 46, 47, 48].contains($0.id) }
        coaUser = coaUser.filter { ![45, 46, 47, 48].contains($0.id) }
        coaUser.append(contentsOf: elementsToMove)
        
        return coaUser
    }
    
    func locationsUser(username: String) async throws -> [Location] {
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(username.lowercased())/locations")!
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token.access_token)", forHTTPHeaderField: "Authorization")
		guard let (data, _) = try? await URLSession.shared.data(for: request) else {
			throw NetworkError.network
		}
        let decoder = JSONDecoder()

		guard let locations = try? decoder.decode([Location].self, from: data) else {
			throw NetworkError.userNotFound
		}

        return locations
    }
    
    func fetchDataUser(username: String) async throws {
            isFinish = false
            self.user = try await userData(username: username)
            self.coalitions = try await coalitionsData(username: username)
            try await Task.sleep(nanoseconds: 1_000_000_000)
            self.locations = try await locationsUser(username: username)
            isFinish = true
    }
}

enum NetworkError: Error {
	case network
	case userNotFound
}
