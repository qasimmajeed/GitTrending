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
    private var cancellable = Set<AnyCancellable>()
    private var network: Networking!
    private var sut: GitRepositoriesUseCase!
    private var requestModel: GitRepositoriesRequest!
    
    // MARK: - XCTestCase Methods
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [GitTrendingMockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        network = Network(urlSession: session)
        sut = GitRepositoriesUseCase(network: network)
        requestModel = GitRepositoriesRequest(search: "", language: "+sort:stars")
    }
    
    override  func tearDown() {
        super.tearDown()
        network = nil
        sut = nil
        requestModel = nil
    }
    
    // MARK: - Test Cases
    func testGitRepositoriesUseCase_WhenGiveRequest_ShouldReturnSuccess() {
        //Arrange
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