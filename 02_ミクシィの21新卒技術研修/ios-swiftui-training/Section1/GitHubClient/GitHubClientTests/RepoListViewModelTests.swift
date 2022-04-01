//
//  GitHubClientTests.swift
//  GitHubClientTests
//
//  Created by HIROKI IKEUCHI on 2022/03/08.
//

import XCTest
@testable import GitHubClient
import Combine

class RepoListViewModelTests: XCTestCase {
    
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        cancellables = .init()
    }
    
    func test_onAppear_正常系() {
        let expectedToBeLoading = expectation(description: "読み込み中のステータスになること")
        let expectedToBeLoaded = expectation(description: "期待通りリポジトリが読み込まれること")
        
        let viewModel = RepoListViewModel(
            repoRepository:
                MockRepoRepository(
                    repos: [.mock1, .mock2]
                ))
        
        viewModel.$repos.sink { result in
            switch result {
            case .loading:
                expectedToBeLoading.fulfill()
            case let .loaded(repos):
                if repos.count == 2 &&
                    repos.map({ $0.id }) == [Repo.mock1.id, Repo.mock2.id] {
                    expectedToBeLoaded.fulfill()
                } else {
                    XCTFail("Unexpected: \(result)")
                }
            default: break
            }
        }.store(in: &cancellables)
        
        viewModel.onAppear()
        
        wait(
            for: [expectedToBeLoading, expectedToBeLoaded],
               timeout: 2.0,
               enforceOrder: true
        )
    }
    
    struct MockRepoRepository: RepoRepository {
        let repos: [Repo]
        
        init(repos: [Repo]) {
            self.repos = repos
        }
        
        func fetchRepos() -> AnyPublisher<[Repo], Error> {
            Just(repos)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
    }
}
