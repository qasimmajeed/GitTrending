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
    private let network: Networking
    
    // MARK: - init
    required init(network: Networking) {
        self.network = network
    }
    
    // MARK: - GitRepositoriesUseCaseProtocol
    func fetchGitRepositories(request: GitRepositoriesRequest) -> AnyPublisher<[Repository], NetworkError> {
        return  self.network.request(request: ApiRequestBuilder(scheme: "http", host: Constants.APIUrls.baseURL, path: Constants.APIPaths.repositories, httpMethod: .Get))
            .mapError { $0 }
            .map { ($0 as GitRepositoryResponse).items }
            .eraseToAnyPublisher()
    }
}
