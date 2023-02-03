//
//  GitRepositoriesUseCaseTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import XCTest
import NetworkFeature
import Combine
@testable import GitTrending


final class GitRepositoriesUseCaseTests: XCTestCase {
    // MARK: - Private Properties
    var cancellable = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
    }
    
    override  func tearDown() {
        super.tearDown()
    }
    
    func testGitRepositoriesUseCase_WhenGiveRequest_ShouldReturnSuccess() {
        //Arrange
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [GitTrendingMockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let network = Network(urlSession: session)
        let sut = GitRepositoriesUseCase(network: network)
        let requestModel = GitRepositoriesRequest(search: "", language: "+sort:stars")
        
        GitTrendingMockURLProtocol.stubResponseData = FakeGitRepositoryData.jsonFakeData.data(using: .utf8)
        
        let expectation = expectation(description: "repository success response expectation")
        var response: [Repository]!
        //Act
        
        sut.fetchGitRepositories(request: requestModel).sink { completion in
            expectation.fulfill()
        } receiveValue: { (values: [Repository]) in
            response = values
            print(values)
        }.store(in: &cancellable)
        
        wait(for: [expectation], timeout: 0.5)
        //Assert
        XCTAssertNotNil(response, "The response should not be nil in the case of valid data")
    }
    
}
