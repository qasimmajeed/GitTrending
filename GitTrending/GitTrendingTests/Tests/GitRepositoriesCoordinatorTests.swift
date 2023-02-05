//
//  GitRepositoriesCoordinatorTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

@testable import GitTrending
import XCTest

final class GitRepositoriesCoordinatorTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGitRepositoriesCoordinator_whenCreate() {
        // Arrange
        let navigation = SpyNavigationController()
        let sut = GitRepositoriesCoordinator(navigationController: navigation, factory: MockGitRepositoriesViewControllerFactory())

        // Act
        sut.start()

        // Assert
        guard let _ = navigation.controller as? GitRepositoriesViewController else {
            XCTFail()
            return
        }
    }
}
