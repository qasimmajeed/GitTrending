//
//  File.swift
//
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import Foundation

/// This class is responsible to handle the mock behaviour of UrlSession
public final class MockURLProtocol: URLProtocol {
    // MARK: - Properties

    public static var stubResponseData: Data?
    public static var stubError: Error?
    public static var mockHttpInvalidResponseCode = false

    // MARK: - URLProtocol overrides

    override public class func canInit(with _: URLRequest) -> Bool {
        return true
    }

    override public class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override public func startLoading() {
        if MockURLProtocol.mockHttpInvalidResponseCode {
            client?.urlProtocol(self, didReceive: HTTPURLResponse(url: request.url!, statusCode: 1009, httpVersion: nil, headerFields: nil) ?? HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
        } else if let error = MockURLProtocol.stubError {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override public func stopLoading() {}
}
