//
//  ApiToken.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 27/11/2023.
//

import Foundation

struct ApiToken: Decodable {
    var access_token: String
    var created_at: Int
    var expires_in: Int
    var refresh_token: String
}
