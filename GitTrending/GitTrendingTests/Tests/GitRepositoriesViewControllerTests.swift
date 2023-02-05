//
//  GitRepositoriesViewControllerTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

@testable import GitTrending
import NetworkFeature
import TestingSupport
import XCTest

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
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.stubError = nil
    }

    func testGitRepositoriesViewController_WhenCreated_ShouldReturnController() {
        // Assert
        XCTAssertNotNil(sut, "The controller should be exits in the storyboard")
        XCTAssertNotNil(storyBoard, "The name of the story board should be proper and exits")
    }

    func testGitRepositoriesViewController_WhenCreated_TheTableViewShouldExits() {
        // Assert
        XCTAssertNotNil(sut.tableView, "The tableView IBOutlet should be connected")
    }

    func testGitRepositoriesViewController_WhenCreated_TitleShouldBeSame() throws {
        // Assert
        let title = try XCTUnwrap(sut.title, "The title should be set")
        XCTAssertEqual(title, mockViewModel.title, "The title is different then in the viewModel")
    }

    func testGitRepositoriesViewController_WhenCreated_TableViewIsConnectedToDelegates() {
        // Assert
        XCTAssertNotNil(sut.tableView.delegate, "The delegate should be assign to tableView")
        XCTAssertNotNil(sut.tableView.dataSource, "The data source delegate should be assign to tableView")
    }

    func testGitRepositoriesViewController_WhenTableLoads_ShouldReturnNumberOfSections() {
        // Assert
        let expectedSectionsCount = mockViewModel.numberOfSections
        XCTAssertEqual(sut.tableView.numberOfSections, expectedSectionsCount, "The number of sections should be equal")
    }

    func testGitRepositoriesViewController_WhenTableLoads_ShouldReturnNumberOfRows() {
        // Assert
        let expectedRowsCount = mockViewModel.numberOfRows
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), expectedRowsCount, "The number of rows should be equal")
    }

    func testGitRepositoriesViewController_WhenTableLoadsAndHaveData_ShouldReturnCell() {
        // Arrange
        MockURLProtocol.stubResponseData = FakeGitRepositoryData.jsonFakeData.data(using: .utf8)
        let ex = expectation(description: "cell check expectation")
        mockViewModel.expectation = ex
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? GitRepositoryTableViewCell

        wait(for: [ex], timeout: 0.5)

        // Assert
        XCTAssertNotNil(cell, "The cell should not be null when having data")
    }

    func testGitRepositoriesViewController_WhenCreated_IsHavingSkeletonable() {
        // Assert
        XCTAssertTrue(sut.tableView.isSkeletonable, "The tableview should be sSkeletonable")
    }

    func testGitRepositoriesViewController_WhenError_ShouldDisplayError() {
        // Arrange
        MockURLProtocol.stubError = NetworkError.inValidResponse
        let ex = expectation(description: "error check expectation")
        mockViewModel.expectation = ex

        wait(for: [ex], timeout: 0.5)

        // Assert
        XCTAssert(mockViewModel.isError, "The error should called")
    }

    func testGitRepositoriesViewController_WhenError_ShouldCallRetry() {
        // Arrange
        MockURLProtocol.stubError = NetworkError.inValidResponse
        let ex = expectation(description: "error check expectation")
        mockViewModel.expectation = ex

        wait(for: [ex], timeout: 0.5)
        sut.retryButtonTap()
        // Assert
        XCTAssert(mockViewModel.isRetryCalled, "The retry should called")
    }

    func testGitRepositoriesViewController_WhenPullToRefreshCalled() {
        // Act
        sut.pullToRefreshAction()

        XCTAssertTrue(mockViewModel.isPullToRefreshCalled, "Should Call the pull To refresh")
    }
}
