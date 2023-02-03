//
//  ApiRequestBuilderTests.swift
//  
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import XCTest
@testable import NetworkFeature

final class ApiRequestBuilderTests: XCTestCase {
    // MARK: - Private Properties
    private var sut: ApiRequestBuilder!
    
    
    override func setUp() {
        super.setUp()
        sut = ApiRequestBuilder(scheme: "http", host: "www.google.com", path: "/images", httpMethod: .Get)
    }
    
    override  func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testApiRequestBuilder_WhenValidRequestDataProvided_ShouldReturnRequest() {
        //Arrange
        do {
            let _ = try sut.makeRequest()
        } catch {
            XCTFail("The request should be return for the valid data provided")
        }
    }
    
    func testApiRequestBuilder_WhenInvalidRequestDataProvided_ShouldThrowError() {
        //Arrange
        let sut = ApiRequestBuilder(scheme: "http", host: "www.google.com", path: "images", httpMethod: .Get)
        //Assert
        XCTAssertThrowsError(try sut.makeRequest(), "The error must be thrown if the url is invalid") { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidRequest)
        }
    }
    
    
}
