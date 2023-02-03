//
//  ApiRequestBuilder.swift
//  
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Foundation

/// Use to have the information regarding the api
public struct ApiRequestBuilder {
    // MARK: - Private Properties
    private let scheme: String
    private let host: String
    private let path: String
    private let httpMethod: HttpMethod
    private let headers: [String: String]?
    
    init(scheme: String, host: String, path: String, httpMethod: HttpMethod, headers: [String: String]? = nil) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.httpMethod = httpMethod
        self.headers = headers
    }
    
    public func makeRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = host
        components.path = path
        components.host = host
        
        guard let url = components.url else {
            throw NetworkError.invalidRequest
        }
        var request = URLRequest(url: url)
        
        let _ = self.headers?.map { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        request.httpMethod = httpMethod.rawValue
        return request
        
        
        
    }
    
}
