//
//  TweetListViewModel.swift
//  TweetImageWithSwiftUIDemo
//
//  Created by HIROKI IKEUCHI on 2022/04/01.
//

import Foundation
import Combine

class TweetListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private (set) var tweets: Stateful<[Tweet]> = .idle
    
    private var cancellables = Set<AnyCancellable>()
    
    private var tweetRepository: TweetRepository
    
    // MARK: - Lifecycles
    
    init(tweetRepository: TweetRepository = MockRepoRepository(tweets: [.tweet1, .tweet2, .tweet3])) {
        self.tweetRepository = tweetRepository
    }
    
    func onAppear() {
        loadTweets()
    }
    
    func onRetryButtonTapped() {
        loadTweets()
    }
    
    // MARK: - Helpers
    
    private func loadTweets() {
        tweetRepository.fetchTweets()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.tweets = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self?.tweets = .failed(error)
                case .finished:
                    print("Finished")                    
                }
            }, receiveValue: { [weak self] tweets in
                self?.tweets = .loaded(tweets)
            })
            .store(in: &cancellables)
        
    }
    
}

