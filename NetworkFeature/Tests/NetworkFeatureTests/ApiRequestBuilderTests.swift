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
        sut = ApiRequestBuilder(scheme: "http", host: "www.google.com", path: "images", httpMethod: .Get)
        //Assert
        XCTAssertThrowsError(try sut.makeRequest(), "The error must be thrown if the url is invalid") { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidRequest)
        }
    }
    
    func testApiRequestBuilder_WhenHttpMethodIsProvided_ShouldContainTheSame() {
        //Assert
        do {
            let request = try sut.makeRequest()
            XCTAssertEqual(request.httpMethod, HttpMethod.Get.rawValue, "The http method is different then provided")
        } catch {
            XCTFail("Valid url parameters should be provided")
        }
    }
    
    func testApiRequestBuilder_WhenHttpHeaderAreProvided_ShouldBeSameAsProvided() throws {
        //Arrange
        let headers = ["content-type": "application/json"]
        sut = ApiRequestBuilder(scheme: "http", host: "www.google.com", path: "/images", httpMethod: .Get, headers: headers)
        //Act
        let request = try sut.makeRequest()
        for (key, value) in headers {
            //Assert
            XCTAssertEqual(value, request.value(forHTTPHeaderField: key), "The \(value) for the header is different then provided")
            break
        }
    }
}
