//
//  NetworkTests.swift
//  
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import XCTest
import Combine
import TestingSupport
@testable import NetworkFeature

/// Having the testCases for the Network
final class NetworkTests: XCTestCase {
    // MARK: - Private Properties
    private var cancellable = Set<AnyCancellable>()
    private var sut: Network!
    private var requestBuilder: ApiRequestBuilder!
    
    // MARK: - XCTestCase Methods
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        sut = Network(urlSession: session)
        requestBuilder = ApiRequestBuilder(scheme: "https", host: "run.mocky.io", path: "/v3/46e3683b-abe2-4eee-a57e-44743ddcf8d5", httpMethod: .Get)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        MockURLProtocol.stubResponseData = nil
        requestBuilder = nil
        MockURLProtocol.stubError = nil
        MockURLProtocol.mockHttpInvalidResponseCode = false
    }
    
    // MARK: - TestCases
    func testNetwork_WhenProvidedValidRequest_ShouldReturnSuccess() {
        //Arrange
        MockURLProtocol.stubResponseData = "{\"status\":\"ok\"}".data(using: .utf8)
        let expectation = self.expectation(description: "Network success expectation")
        var response: DummyResponseModel!
        
        //Act
        sut.request(request: requestBuilder).sink { completion in
            expectation.fulfill()
        } receiveValue: { (value: DummyResponseModel) in
            response = value
        }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 0.5)
        
        //Assert
        XCTAssertNotNil(response, "The success response should not be nil")
    }
    
    func testNetwork_WhenInvalidResponseProvided_ShouldCauseError() {
        //Arrange
        MockURLProtocol.stubResponseData = "{\"stats\":\"ok\"}".data(using: .utf8)
        let expectation = self.expectation(description: "Network failure expectation")
        var response: DummyResponseModel!
        var networkError: NetworkError!
        
        //Act
        sut.request(request: requestBuilder).sink(receiveCompletion: { completion in
            switch completion {
            case.failure(let error):
                networkError = error
                expectation.fulfill()
            default :
                expectation.fulfill()
            }
        }, receiveValue: { (value: DummyResponseModel) in
            response = value
        }).store(in: &cancellable)
        
        wait(for: [expectation], timeout: 0.5)
        
        //Assert
        XCTAssertNotNil(networkError, "The error should be produce if the invalid response provided ")
        XCTAssertEqual(networkError, NetworkError.inValidResponse, "The inValidResponse should be thrown in the case of invalid response of data")
        XCTAssertNil(response, "Should provide the valid response model otherwise it cause error")
    }
    
    func testNetwork_WhenInValidHttpResponse_ShouldCauseError() {
        //Arrange
        MockURLProtocol.stubError = NetworkError.inValidResponse
        let expectation = self.expectation(description: "Network invalid http expectation")
        var networkError: NetworkError!
        
        //Act
        sut.request(request: requestBuilder).sink(receiveCompletion: { completion in
            switch completion {
            case.failure(let error):
                networkError = error
                expectation.fulfill()
            default :
                expectation.fulfill()
            }
        }, receiveValue: { (value: DummyResponseModel) in
        }).store(in: &cancellable)
        
        wait(for: [expectation], timeout: 0.5)
        
        //Assert
        XCTAssertNotNil(networkError, "The error should be produce if the invalid response provided ")
        XCTAssertEqual(networkError, NetworkError.inValidResponse, "The inValidResponse should case in the case of invalid response")
    }
    
    func testNetwork_WhenInvalidHttpStatusCode_ShouldPlaceError() {
        //Arrange
        let expectation = self.expectation(description: "Network invalid http status code expectation")
        var networkError: NetworkError!
        MockURLProtocol.mockHttpInvalidResponseCode = true
        
        //Act
        sut.request(request: requestBuilder).sink(receiveCompletion: { completion in
            switch completion {
            case.failure(let error):
                networkError = error
                expectation.fulfill()
            default :
                expectation.fulfill()
            }
        }, receiveValue: { (value: DummyResponseModel) in
        }).store(in: &cancellable)
        
        wait(for: [expectation], timeout: 0.5)
        
        //Assert
        XCTAssertNotNil(networkError, "The error should be produce if the invalid response provided")
        XCTAssertEqual(networkError, NetworkError.inValidHTTPResponse(code: 1009), "The inValidHTTPResponse should case in the case of invalid response")
    }
    
    func testNetwork_InvalidRequest_ShouldCauseError() {
        let expectation = self.expectation(description: "Network invalid request expectation")
        var networkError: NetworkError!
        requestBuilder = ApiRequestBuilder(scheme: "https", host: "run.mockyo", path: "6e3683b-abe2-4eee-a57e-44743ddcf8d5", httpMethod: .Get)
        
        //Act
        sut.request(request: requestBuilder).sink(receiveCompletion: { completion in
            switch completion {
            case.failure(let error):
                networkError = error
                expectation.fulfill()
            default :
                expectation.fulfill()
            }
        }, receiveValue: { (value: DummyResponseModel) in
            
        }).store(in: &cancellable)
        
        wait(for: [expectation], timeout: 0.5)
        
        //Assert
        XCTAssertNotNil(networkError, "The error should throw for invalid request")
        XCTAssertEqual(networkError, NetworkError.invalidURL, "Then invalidURL should thrown ")
    }
}
