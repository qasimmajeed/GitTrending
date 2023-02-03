//
//  NetworkTests.swift
//  
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import XCTest
import Combine
@testable import NetworkFeature

final class NetworkTests: XCTestCase {
    // MARK: - Private Properties
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - XCTestCase Methods
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - TestCases
    func testNetwork_WhenProvidedValidRequest_ShouldReturnSuccess() {
        //Arrange
        
        MockURLProtocol.stubResponseData = "{\"status\":\"ok\"}".data(using: .utf8)
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let sut = Network(urlSession: session)
        let requestBuilder = ApiRequestBuilder(scheme: "https", host: "run.mocky.io", path: "/v3/46e3683b-abe2-4eee-a57e-44743ddcf8d5", httpMethod: .Get)
        let expectation = self.expectation(description: "Network success expectation")
        var response: DummyResponseModel!
        
        //Act
        sut.request(request: requestBuilder).sink { completion in
            expectation.fulfill()
        } receiveValue: { (value: DummyResponseModel) in
            response = value
        }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 1.0)
        
        //Assert
        XCTAssertNotNil(response, "The success response should not be nil")
    }
    
}
