//
//  GitRepositoriesUseCase.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Foundation
import NetworkFeature
import Combine

protocol GitRepositoriesUseCaseProtocol {
    // This will the git repositories by given `request`.
    /// - Parameters
    ///     - request:  The provided request.
    /// - Returns  AnyPublisher: with the repositories or in the case of error
    func fetchGitRepositories(request: GitRepositoriesRequest) -> AnyPublisher<[Repository], NetworkError>
    
    /// To create the GitRepositoriesUseCaseProtocol object
    /// - Parameter network: provide the object of networking
    init(network: Networking)
}

final class GitRepositoriesUseCase: GitRepositoriesUseCaseProtocol{
    // MARK: - Private Properties
    private let network: Networking
    
    // MARK: - init
    init(network: Networking = Network(urlSession: URLSession.shared)) {
        self.network = network
    }
    
    // MARK: - GitRepositoriesUseCaseProtocol
    func fetchGitRepositories(request: GitRepositoriesRequest) -> AnyPublisher<[Repository], NetworkError> {
        var queryParameters: [String: String] = [String: String]()
        queryParameters["q"] = request.search
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
