//
//  Network.swift
//
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Combine
import Foundation

/// his protocol the use to implement for remote networking api
public protocol Networking {
    ///  Create a request and perform over the provided network api
    /// - Parameter request: ApiRequestBuilder that have all the information for the call api request
    /// - Returns  AnyPublisher: Publisher which will be having the T generic type for response as decodable  or error(NetworkError) in case of
    func request<T: Decodable>(request: ApiRequestBuilder) -> AnyPublisher<T, NetworkError>
}

/// The class is responsible to handle the network call in the app
public final class Network: Networking {
    // MARK: - Private Properties

    private let urlSession: URLSession

    // MARK: - Init

    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    public func request<T: Decodable>(request: ApiRequestBuilder) -> AnyPublisher<T, NetworkError> {
        guard let urlRequest = try? request.makeRequest() else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        return urlSession.dataTaskPublisher(for: urlRequest)
            .tryMap { element -> Data in
                if let httpResponse = element.response as? HTTPURLResponse {
                    if 200 ... 300 ~= httpResponse.statusCode {
                        return element.data
                    } else {
                        throw NetworkError.inValidHTTPResponse(code: httpResponse.statusCode)
                    }
                }
                throw NetworkError.inValidResponse
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { $0 as? NetworkError ?? NetworkError.inValidResponse }
            .eraseToAnyPublisher()
    }
}
