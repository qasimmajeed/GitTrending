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
    
    public func request<T: Decodable>(request: ApiRequestBuilder) -> AnyPublisher<T, NetworkError> {
        let urlRequest = try! request.makeRequest()
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest).map { (element) -> Data in
            print(element.data)
            return element.data
        }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                return NetworkError.invalidRequest
            }
            .eraseToAnyPublisher()
    }
    
}
