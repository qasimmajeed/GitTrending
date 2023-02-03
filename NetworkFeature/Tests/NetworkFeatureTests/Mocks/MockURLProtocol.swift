//
//  MockURLProtocol.swift
//  
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Foundation

/// This class is responsible to handle the mock behaviour of UrlSession
final class MockURLProtocol: URLProtocol {
    // MARK: - Properties
    static var stubResponseData: Data?
    
    // MARK: - URLProtocol overrides
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        self.client?.urlProtocol(self, didReceive: URLResponse(), cacheStoragePolicy: .notAllowed)
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
    
}
