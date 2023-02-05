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
    
    func testErrorView_WhenLoads_ShouldHaveDefaultValues() throws {
        //Arrange
        let sut: ErrorView = ErrorView.loadViewFromXib()!
        _ = try XCTUnwrap(sut.animationView, "The animationView IBOutlet should be connected")
        let someThingWrongLabel = try XCTUnwrap(sut.someThingWrongLabel, "The someThingWrongLabel IBOutlet should be connected")
        let errorDetailLabel = try XCTUnwrap(sut.errorDetailLabel, "The errorDetailLabel IBOutlet should be connected")
        let retryButton = try XCTUnwrap(sut.retryButton, "The retryButton IBOutlet should")
        
        //Assert
        XCTAssertEqual(someThingWrongLabel.text, "Something went wrong..", "The someThingWrongLabel not empty when the cell load")
        XCTAssertEqual(errorDetailLabel.text, "An alien is probably blocking your signal.", "The errorDetailLabel not empty when the cell load")
        XCTAssertEqual(retryButton.titleLabel?.text, "RETRY", "The retryButton not empty when the cell load")
       
        
        
    }
}
