//
//  GitRepositoriesViewModelTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Combine
@testable import GitTrending
import NetworkFeature
import TestingSupport
import XCTest

final class GitRepositoriesViewModelTests: XCTestCase {
    // MARK: - Private Properties

    private var cancellable = Set<AnyCancellable>()
    private var network: Networking!
    private var sut: GitRepositoriesViewModel!
    private var mockUseCase: MockRepositoriesUseCases!

    override func setUp() {
        super.setUp()
        network = NetworkStub.stub
        mockUseCase = MockRepositoriesUseCases(network: network)
        sut = GitRepositoriesViewModel(useCase: mockUseCase)
    }

    override func tearDown() {
        super.tearDown()
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.stubError = nil
    }

    func testGitRepositoriesViewModel_WhenFetch_ShouldHaveLoadingState() {
        // Arrange
        var isLoadingState = false
        sut.stateDidUpdate.sink { state in
            if state == .loading {
                isLoadingState = true
            }
        }.store(in: &cancellable)

        // Act
        sut.fetchRepositories()

        // Assert
        XCTAssertTrue(isLoadingState, "The state should be loading")
    }

    func testGitRepositoriesViewModel_WhenFetch_ShouldShowRepositories() {
        // Arrange
        var isShowRepositoriesState = false
        let expectation = expectation(description: "repository success response expectation")
        MockURLProtocol.stubResponseData = FakeGitRepositoryData.jsonFakeData.data(using: .utf8)

        sut.stateDidUpdate.sink { state in
            if state == .showRepositories {
                isShowRepositoriesState = true
                expectation.fulfill()
            }
        }.store(in: &cancellable)

        // Act
        sut.fetchRepositories()

        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertTrue(isShowRepositoriesState, "The state should be repositories")
    }

    func testGitRepositoriesViewModel_WhenAfterFetch_ShouldHideLoading() {
        var isLoadingHidden = false
        let expectation = expectation(description: "when is loading is done expectation")
        MockURLProtocol.stubResponseData = FakeGitRepositoryData.jsonFakeData.data(using: .utf8)

        sut.stateDidUpdate.sink { state in
            if state == .hideLoading {
                isLoadingHidden = true
                expectation.fulfill()
            }
        }.store(in: &cancellable)

        // Act
        sut.fetchRepositories()

        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertTrue(isLoadingHidden, "The state should be repositories")
    }

    func testGitRepositoriesViewModel_WhenFetchingCauseError_ShouldShowError() {
        var isErrorShown = false
        let expectation = expectation(description: "error shown expectation")
        MockURLProtocol.stubError = NetworkError.invalidRequest

        sut.stateDidUpdate.sink { state in
            if state == .showError {
                isErrorShown = true
                expectation.fulfill()
            }
        }.store(in: &cancellable)

        // Act
        sut.fetchRepositories()

        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertTrue(isErrorShown, "The state should be showError")
    }

    func testGitRepositoriesViewModel_TheTitleMustSame() {
        // Assert
        XCTAssertEqual(sut.title, "Trending")
    }

    func testGitRepositoriesViewModel_WhenData_ShouldReturnCellViewModel() {
        // Arrange
        let expectation = expectation(description: "repository success response expectation")
        MockURLProtocol.stubResponseData = FakeGitRepositoryData.jsonFakeData.data(using: .utf8)
        var cellViewModel: GitRepositoryCellViewModel!
        sut.stateDidUpdate.sink { state in
            if state == .showRepositories {
                cellViewModel = self.sut.cellViewModelAtIndex(index: 0)
                expectation.fulfill()
            }
        }.store(in: &cancellable)

        // Act
        sut.fetchRepositories()

        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertNotNil(cellViewModel, "The cell viewModel should return not nil")
    }

    func testGitRepositoriesViewModel_WhenCellDidSelect_ShouldUpdateTheState() {
        // Arrange
        let expectation = expectation(description: "repository ShouldUpdateTheState expectation")
        MockURLProtocol.stubResponseData = FakeGitRepositoryData.jsonFakeData.data(using: .utf8)
        var isSelectedCalled = false
        var callCount = 0
        sut.stateDidUpdate.sink { state in
            if state == .showRepositories {
                callCount += 1
                if callCount == 1 {
                    self.sut.didSelectAtIndex(index: 0)
                    isSelectedCalled = true
                    expectation.fulfill()
                }
            }
        }.store(in: &cancellable)

        // Act
        sut.fetchRepositories()

        wait(for: [expectation], timeout: 0.5)

        // Assert
        XCTAssertTrue(isSelectedCalled, "Should call the didSelectAtIndex")
    }
}
