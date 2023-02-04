//
//  GitRepositoriesViewModelTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import XCTest
import Combine
import NetworkFeature
@testable import GitTrending

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
        GitTrendingMockURLProtocol.stubResponseData = nil
        GitTrendingMockURLProtocol.stubError = nil
    }
    
    func testGitRepositoriesViewModel_WhenFetch_ShouldHaveLoadingState() {
        //Arrange
        var isLoadingState = false
        sut.stateDidUpdate.sink { state in
            if state == .loading {
                isLoadingState = true
            }
        }.store(in: &cancellable)
        
        //Act
        sut.fetchRepositories()
        
        //Assert
        XCTAssertTrue(isLoadingState, "The state should be loading")
    }
    
    func testGitRepositoriesViewModel_WhenFetch_ShouldShowRepositories() {
        //Arrange
        var isShowRepositoriesState = false
        let expectation = expectation(description: "repository success response expectation")
        GitTrendingMockURLProtocol.stubResponseData = FakeGitRepositoryData.jsonFakeData.data(using: .utf8)
        
        sut.stateDidUpdate.sink { state in
            if state == .showRepositories {
                isShowRepositoriesState = true
                expectation.fulfill()
            }
        }.store(in: &cancellable)
        
        //Act
        sut.fetchRepositories()
        
        wait(for: [expectation], timeout: 0.5)
        
        //Assert
        XCTAssertTrue(isShowRepositoriesState, "The state should be repositories")
    }
    
    func testGitRepositoriesViewModel_WhenAfterFetch_ShouldHideLoading() {
        var isLoadingHidden = false
        let expectation = expectation(description: "when is loading is done expectation")
        GitTrendingMockURLProtocol.stubResponseData = FakeGitRepositoryData.jsonFakeData.data(using: .utf8)
        
        sut.stateDidUpdate.sink { state in
            if state == .hideLoading {
                isLoadingHidden = true
                expectation.fulfill()
            }
        }.store(in: &cancellable)
        
        //Act
        sut.fetchRepositories()
        
        wait(for: [expectation], timeout: 0.5)
        
        //Assert
        XCTAssertTrue(isLoadingHidden, "The state should be repositories")
        
    }
    
    func testGitRepositoriesViewModel_WhenFetchingCauseError_ShouldShowError() {
        var isErrorShown = false
        let expectation = expectation(description: "error shown expectation")
        GitTrendingMockURLProtocol.stubError = NetworkError.invalidRequest
        
        sut.stateDidUpdate.sink { state in
            if state == .showError {
                isErrorShown = true
                expectation.fulfill()
            }
        }.store(in: &cancellable)
        
        //Act
        sut.fetchRepositories()
        
        wait(for: [expectation], timeout: 0.5)
        
        //Assert
        XCTAssertTrue(isErrorShown, "The state should be showError")
        
    }
    
}
