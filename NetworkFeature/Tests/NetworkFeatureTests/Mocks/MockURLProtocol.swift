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
    static var stubError: Error?
    static var mockHttpInvalidResponseCode = false
    
    // MARK: - URLProtocol overrides
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if MockURLProtocol.mockHttpInvalidResponseCode {
            self.client?.urlProtocol(self, didReceive: HTTPURLResponse(url: request.url!, statusCode: 1009, httpVersion: nil, headerFields: nil) ?? HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
        } else if let error = MockURLProtocol.stubError {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {
            self.client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
    
}
