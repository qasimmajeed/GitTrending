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
    
    init(scheme: String, host: String, path: String, httpMethod: HttpMethod) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.httpMethod = httpMethod
    }
    
    public func makeRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = host
        components.path = path
        components.host = host
        
        // TOD: perform the safe check the throw error
        
        var request = URLRequest(url:  components.url!)
        request.httpMethod = httpMethod.rawValue
        return request
        
        
    }
    
}
