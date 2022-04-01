//
//  Tweet.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/03/31.
//

import Foundation

struct Tweet: Identifiable, Codable {
    let id: Int
    let user: User
    let text: String
    let images: [String]
    var favoritedCount: Int
    var retweetedCount: Int
    var replyCount: Int
}
