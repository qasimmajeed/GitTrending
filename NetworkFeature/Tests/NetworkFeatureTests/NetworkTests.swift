//
//  NetworkTests.swift
//  
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import XCTest
@testable import NetworkFeature

final class NetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNetwork_WhenProvidedValidRequest_ShouldReturnSuccess() {
        //Arrange
        let sut = Network()
        let requestBuilder = ApiRequestBuilder()
        
        //Act
        
        sut.request(request: requestBuilder)
        
        
        //Asset
    }
    
}
