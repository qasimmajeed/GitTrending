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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGitRepositoriesViewModel_WhenFetch_ShouldHaveLoadingState() {
        //Arrange
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [GitTrendingMockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let network = Network(urlSession: session)
        let mockUseCase = MockRepositoriesUseCases(network: network)
        let sut = GitRepositoriesViewModel(useCase: mockUseCase)
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
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [GitTrendingMockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let network = Network(urlSession: session)
        let mockUseCase = MockRepositoriesUseCases(network: network)
        let sut = GitRepositoriesViewModel(useCase: mockUseCase)
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
}
