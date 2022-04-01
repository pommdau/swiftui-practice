//
//  User.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/03/31.
//

import SwiftUI

struct User: Identifiable, Codable {
    let id: String
    let icon: String
    let userName: String
    let screenName: String
    
    init(id: String, icon: String = "TwitterMark", userName: String, screenName: String) {
        self.id = id
        self.icon = icon
        self.userName = userName
        self.screenName = screenName
    }
    
}
