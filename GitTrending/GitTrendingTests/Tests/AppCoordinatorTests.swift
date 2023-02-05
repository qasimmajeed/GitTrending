//
//  AppCoordinatorTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

@testable import GitTrending
import XCTest

final class AppCoordinatorTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_WhenLaunch_TheGitRepositoriesShouldShow() {
        // Arrange
        let window = UIWindow()
        let navigationController = SpyNavigationController()
        let sut = AppCoordinator(window: window, navigation: navigationController)

        // Act
        sut.start()

        // Assert
        guard let _ = navigationController.controller as? GitRepositoriesViewController else {
            XCTFail()
            return
        }
    }
}
