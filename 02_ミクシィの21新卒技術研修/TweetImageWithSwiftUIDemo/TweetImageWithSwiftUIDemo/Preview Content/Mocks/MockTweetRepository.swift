//
//  MockTweetRepository.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/04/01.
//

import Foundation
import Combine

struct MockRepoRepository: TweetRepository {
    let tweets: [Tweet]
    let error: Error?

    init(tweets: [Tweet], error: Error? = nil) {
        self.tweets = tweets
        self.error = error
    }

    func fetchTweets() -> AnyPublisher<[Tweet], Error> {
        if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }

        return Just(tweets)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

    
