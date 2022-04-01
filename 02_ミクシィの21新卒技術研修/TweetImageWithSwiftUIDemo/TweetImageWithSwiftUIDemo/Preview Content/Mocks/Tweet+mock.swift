//
//  Tweet+mock.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/03/31.
//

import Foundation

extension Tweet {
    static let lorem = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad.
"""
    
    static let tweet1 = Tweet(id: 1, user: .mock1, text: lorem, images: ["TweetImage_01"], favoritedCount: 10, retweetedCount: 10, replyCount: 10)
    static let tweet2 = Tweet(id: 2, user: .mock2, text: lorem, images: ["TweetImage_01"], favoritedCount: 20, retweetedCount: 20, replyCount: 20)
    static let tweet3 = Tweet(id: 3, user: .mock3, text: lorem, images: ["TweetImage_01"], favoritedCount: 30, retweetedCount: 30, replyCount: 30)
}
