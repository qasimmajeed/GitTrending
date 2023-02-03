//
//  MockRepositoriesUseCases.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Foundation
import NetworkFeature
import Combine
@testable import GitTrending

class MockRepositoriesUseCases: GitRepositoriesUseCaseProtocol {
    // MARK: - Private Properties
    private var dataPublisherRepository: PassthroughSubject<[Repository], NetworkError> = PassthroughSubject<[Repository], NetworkError>()
    
    // MARK: - GitRepositoriesUseCaseProtocol
    func fetchGitRepositories(request: GitTrending.GitRepositoriesRequest) -> AnyPublisher<[Repository], NetworkError> {
        return dataPublisherRepository.eraseToAnyPublisher()
    }
    
    func sendRepositories() {
        dataPublisherRepository.send(FakeGitRepositoryData.fakeRepositories.items)
    }
}
