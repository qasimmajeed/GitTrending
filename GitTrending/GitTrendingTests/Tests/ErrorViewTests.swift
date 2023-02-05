//
//  ErrorViewTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import XCTest
import Lottie
@testable import GitTrending

final class ErrorViewTests: XCTestCase {
    // MARK: - Private Properties
    private var sut:ErrorView!
    override func setUp() {
        super.setUp()
        sut = ErrorView.loadViewFromXib()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testErrorView_WhenLoadXib_ShouldReturnView() {
        XCTAssertNotNil(sut)
    }
    
    func testErrorView_WhenLoads_ShouldHaveDefaultValues() throws {
        //ArrangeU
        _ = try XCTUnwrap(sut.animationView, "The animationView IBOutlet should be connected")
        let someThingWrongLabel = try XCTUnwrap(sut.someThingWrongLabel, "The someThingWrongLabel IBOutlet should be connected")
        let errorDetailLabel = try XCTUnwrap(sut.errorDetailLabel, "The errorDetailLabel IBOutlet should be connected")
        let retryButton = try XCTUnwrap(sut.retryButton, "The retryButton IBOutlet should")
        
        //Assert
        XCTAssertEqual(someThingWrongLabel.text, "Something went wrong..", "The someThingWrongLabel not empty when the cell load")
        XCTAssertEqual(errorDetailLabel.text, "An alien is probably blocking your signal.", "The errorDetailLabel not empty when the cell load")
        XCTAssertEqual(retryButton.titleLabel?.text, "RETRY", "The retryButton not empty when the cell load")
    }
    
    func testErrorView_WhenLoads_AnimationViewShouldBeLottie() throws {
        //ArrangeU
        let animationView = try XCTUnwrap(sut.animationView, "The animationView IBOutlet should be connected")
        XCTAssertTrue((animationView as Any) is LottieAnimationView, "The view should be LottieAnimationView")
    }
}
