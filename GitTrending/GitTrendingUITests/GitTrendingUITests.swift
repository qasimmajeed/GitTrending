//
//  GitTrendingUITests.swift
//  GitTrendingUITests
//
//  Created by Muhammad Qasim Majeed on 28/02/2023.
//

import XCTest

final class GitTrendingUITests: XCTestCase {
    // MARK: - Properties

    var application: XCUIApplication!

    override func setUp() {
        super.setUp()
        application = XCUIApplication()
    }

    override func tearDown() {
        super.tearDown()
        application = nil
    }

    func testGitTrending_WhenLaunch_ShouldValidView() {
        // Arrange
        application.launch()

        // Act
        let table = application.tables["tableView"]

        // Assert
        XCTAssertTrue(table.exists, "Should have tableview")
    }

    func testGitTrending_WhenLaunchWithSuccess_ShouldValidDataState() {
        // Arrange
        application.launchArguments = ["ui-Testing", "success"]
        application.launch()

        // Act
        let table = application.tables["tableView"]

        // Assert
        XCTAssertTrue(table.cells.count > 0, "The table view should have data")
    }

    func testGitTrending_WhenLaunchWithError_ShouldShowErrorView() {
        // Arrange
        application.launchArguments = ["ui-Testing", "error"]
        application.launch()

        // Act
        let errorView = application.otherElements["errorView"]
        let retryButton = errorView.buttons["retryButton"]

        // Assert
        XCTAssertTrue(retryButton.exists, "Should have retry button")
        XCTAssertTrue(errorView.exists, "Should Show error")
    }
}
