//
//  GitRepositoriesViewControllerTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import XCTest
@testable import GitTrending

final class GitRepositoriesViewControllerTests: XCTestCase {
    
    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGitRepositoriesViewController_WhenCreated_ShouldReturnController() {
        //Arrange
        let sut: GitRepositoriesViewController!
        let storyBoard = UIStoryboard(name: "GitRepositories", bundle: nil)
        
        //Act
        sut = storyBoard.instantiateViewController(withIdentifier: "GitRepositoriesViewController") as? GitRepositoriesViewController
        
        //Assert
        XCTAssertNotNil(sut, "The controller should be exits in the storyboard")
        XCTAssertNotNil(storyBoard, "The name of the story board should be proper and exits")
    }
    
    func testGitRepositoriesViewController_WhenCreated_TheTableViewShouldExits() {
        //Arrange
        let sut: GitRepositoriesViewController!
        let storyBoard = UIStoryboard(name: "GitRepositories", bundle: nil)
        sut = storyBoard.instantiateViewController(withIdentifier: "GitRepositoriesViewController") as? GitRepositoriesViewController
        
        //Act
        sut.loadViewIfNeeded()
        
        //Assert
        XCTAssertNotNil(sut.tableView, "The tableView IBOutlet should be connected")
    }
    
}
