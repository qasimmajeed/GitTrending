//
//  GitRepositoriesCoordinatorTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import XCTest
@testable import GitTrending

final class GitRepositoriesCoordinatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGitRepositoriesCoordinator_whenCreate() {
        //Arrange
        let navigation = SpyNavigationController()
        let sut = GitSearchRepositoriesCoordinator(navigationController: navigation, factory: MockGitRepositoriesViewControllerFactory())
        
        //Act
        sut.start()
        
        //Assert
        guard let _ = navigation.controller as? GitRepositoriesViewController else {
            XCTFail()
            return
        }
    }
}
