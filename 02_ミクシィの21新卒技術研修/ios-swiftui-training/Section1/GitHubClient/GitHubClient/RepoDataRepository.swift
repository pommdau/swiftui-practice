//
//  RepoRepository.swift
//  GitHubClient
//
//  Created by HIROKI IKEUCHI on 2022/03/04.
//

import Foundation
import Combine

protocol RepoRepository {
    func fetchRepos() -> AnyPublisher<[Repo], Error>
}

struct RepoDataRepository: RepoRepository {
    func fetchRepos() -> AnyPublisher<[Repo], Error> {
        RepoAPIClient().getRepos()
    }
}
