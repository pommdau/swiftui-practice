//
//  TweetRepository.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/03/31.
//

import Foundation
import Combine

protocol TweetRepository {
    func fetchTweets() -> AnyPublisher<[Tweet], Error>
}

//struct TweetDataRepository: TweetRepository {
//    func fetchTweets() -> AnyPublisher<[Tweet], Error> {
//        TwitterAPIClient.fet
//    }
//
//}

