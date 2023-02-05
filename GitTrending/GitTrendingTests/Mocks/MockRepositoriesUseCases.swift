//
//  MockRepositoriesUseCases.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Combine
import Foundation
@testable import GitTrending
import NetworkFeature

final class MockRepositoriesUseCases: GitRepositoriesUseCaseProtocol {
    // MARK: - Private Properties

    private let network: Networking

    // MARK: - init

    required init(network: Networking) {
        self.network = network
    }

    // MARK: - GitRepositoriesUseCaseProtocol

    func fetchGitRepositories(request _: GitRepositoriesRequest) -> AnyPublisher<[Repository], NetworkError> {
        return network.request(request: FakeGitRepositoryData.fakeRequest)
            .mapError { $0 }
            .map { ($0 as GitRepositoryResponse).items }
            .eraseToAnyPublisher()
    }
}
