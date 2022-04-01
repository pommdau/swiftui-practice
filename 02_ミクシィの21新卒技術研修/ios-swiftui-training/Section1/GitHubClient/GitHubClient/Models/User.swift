//
//  User.swift
//  GitHubClient
//
//  Created by HIROKI IKEUCHI on 2022/03/02.
//

import Foundation

struct User: Codable {
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "login"
    }
}
