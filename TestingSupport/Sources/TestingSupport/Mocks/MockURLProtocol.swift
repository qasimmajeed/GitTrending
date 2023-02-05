//
//  File.swift
//  
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import Foundation

/// This class is responsible to handle the mock behaviour of UrlSession
final public class MockURLProtocol: URLProtocol {
    // MARK: - Properties
    static public var stubResponseData: Data?
    static public var stubError: Error?
    static public var mockHttpInvalidResponseCode = false
    
    // MARK: - URLProtocol overrides
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
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
    
    public override func stopLoading() { }
}
