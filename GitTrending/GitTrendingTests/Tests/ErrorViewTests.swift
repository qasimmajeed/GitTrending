//
//  ErrorViewTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import XCTest
@testable import GitTrending

final class ErrorViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testErrorView_WhenLoadXib_ShouldReturnView() {
        //Arrange
        let sut = ErrorView.loadViewFromXib()
        //Assert
        XCTAssertNotNil(sut)
    }
}
