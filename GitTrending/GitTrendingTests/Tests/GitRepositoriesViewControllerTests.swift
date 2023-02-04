//
//  GitRepositoriesViewControllerTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import XCTest
@testable import GitTrending

final class GitRepositoriesViewControllerTests: XCTestCase {
    // MARK: - Private Properties
    private var sut: GitRepositoriesViewController!
    private var storyBoard: UIStoryboard!
    private var mockUseCase: MockRepositoriesUseCases!
    private var mockViewModel: MockGitRepositoriesViewModel!
    
    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()
        storyBoard = UIStoryboard(name: .gitRepositories)
        mockUseCase = MockRepositoriesUseCases(network: NetworkStub.stub)
        mockViewModel = MockGitRepositoriesViewModel(useCase: mockUseCase)
        sut = storyBoard.instantiateViewController(identifier: "GitRepositoriesViewController") {
            GitRepositoriesViewController(coder: $0, viewModel: self.mockViewModel)
            
        }
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        storyBoard = nil
        mockViewModel = nil
        mockUseCase = nil
    }
    
    func testGitRepositoriesViewController_WhenCreated_ShouldReturnController() {
        //Assert
        XCTAssertNotNil(sut, "The controller should be exits in the storyboard")
        XCTAssertNotNil(storyBoard, "The name of the story board should be proper and exits")
    }
    
    func testGitRepositoriesViewController_WhenCreated_TheTableViewShouldExits() {
        //Assert
        XCTAssertNotNil(sut.tableView, "The tableView IBOutlet should be connected")
    }
    
    func testGitRepositoriesViewController_WhenCreated_TitleShouldBeSame() throws {
        //Assert
        let title = try XCTUnwrap(sut.title, "The title should be set")
        XCTAssertEqual(title, mockViewModel.title, "The title is different then in the viewModel")
    }
    
    func testGitRepositoriesViewController_WhenCreated_TableViewIsConnectedToDelegates() {
        //Assert
        XCTAssertNotNil(sut.tableView.delegate, "The delegate should be assign to tableView")
        XCTAssertNotNil(sut.tableView.dataSource, "The data source delegate should be assign to tableView")
    }
    
}
