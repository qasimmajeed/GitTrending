//
//  Network.swift
//  
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Foundation
import Combine

/// The class is responsible to handle the network call in the app
final public class Network {
    // MARK: - Private Properties
    private let urlSession: URLSession
    
    // MARK: - Init
    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    public func request<T: Decodable>(request: ApiRequestBuilder) -> AnyPublisher<T, NetworkError> {
        let urlRequest = try! request.makeRequest()
        
        return urlSession.dataTaskPublisher(for: urlRequest).map { (element) -> Data in
            print(element.data)
            return element.data
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError { error -> NetworkError in
            return NetworkError.inValidResponse
        }
        .eraseToAnyPublisher()
    }
    
}
