//
//  UserDatas.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 27/11/2023.
//

import Foundation

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
