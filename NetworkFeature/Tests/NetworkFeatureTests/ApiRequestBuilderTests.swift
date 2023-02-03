//
//  ApiRequestBuilderTests.swift
//  
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import XCTest
@testable import NetworkFeature

final class ApiRequestBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override  func tearDown() {
        super.tearDown()
    }
    
    func testApiRequestBuilder_WhenValidRequestDataProvided_ShouldReturnRequest() {
        //Arrange
        let sut = ApiRequestBuilder(scheme: "http", host: "www.google.com", path: "/images", httpMethod: .Get)
        
        //Act
        let request = sut.makeRequest()
        
        //Assert
        
        XCTAssertNotNil(request, "The request should be return for the valid data provided")
    }
    
}
