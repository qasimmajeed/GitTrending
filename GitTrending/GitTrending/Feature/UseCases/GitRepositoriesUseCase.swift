//
//  GitRepositoriesUseCase.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Foundation
import NetworkFeature
import Combine

final class GitRepositoriesUseCase {
    // MARK: - Private Properties
    private let network: Networking
    
    // MARK: - init
    init(network: Networking) {
        self.network = network
    }
    
    func fetchGitRepositories(request: GitRepositoriesRequest) -> AnyPublisher<[Repository], NetworkError> {
        var queryParameters: [String: String] = [String: String]()
        queryParameters["q"] = request.search
        queryParameters["language"] = request.language
        let requestBuilder = ApiRequestBuilder(scheme: "https",
                                               host: Constants.APIUrls.baseURL,
                                               path: Constants.APIPaths.repositories, httpMethod: .Get,
                                               queryParameters: queryParameters)
        return self.network.request(request: requestBuilder)
            .mapError { $0 }
            .map { ($0 as GitRepositoryResponse).items }
            .eraseToAnyPublisher()
    }
}
