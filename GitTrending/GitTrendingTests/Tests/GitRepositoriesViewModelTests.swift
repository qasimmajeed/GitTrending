//
//  GitRepositoriesViewModelTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import XCTest
import Combine
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
        let mockUseCase = MockRepositoriesUseCases()
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
}
