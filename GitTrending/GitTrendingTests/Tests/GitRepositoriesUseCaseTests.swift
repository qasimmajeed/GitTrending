//
//  GitRepositoriesUseCaseTests.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Combine
@testable import GitTrending
import NetworkFeature
import TestingSupport
import XCTest

final class GitRepositoriesUseCaseTests: XCTestCase {
    // MARK: - Private Properties

    private var cancellable = Set<AnyCancellable>()
    private var network: Networking!
    private var sut: GitRepositoriesUseCase!
    private var requestModel: GitRepositoriesRequest!

    // MARK: - XCTestCase Methods

    override func setUp() {
        super.setUp()
        network = NetworkStub.stub
        sut = GitRepositoriesUseCase(network: network)
        requestModel = GitRepositoriesRequest(search: "language=+sort:stars")
    }

    override func tearDown() {
        super.tearDown()
        network = nil
        sut = nil
        requestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.stubError = nil
    }

    // MARK: - Test Cases

    func testGitRepositoriesUseCase_WhenGiveRequest_ShouldReturnSuccess() {
        // Arrange
        MockURLProtocol.stubResponseData = FakeGitRepositoryData.jsonFakeData.data(using: .utf8)
        let expectation = expectation(description: "repository success response expectation")
        var response: [Repository]!

        // Act
        sut.fetchGitRepositories(request: requestModel).sink { _ in
            expectation.fulfill()
        } receiveValue: { (values: [Repository]) in
            response = values
            print(values)
        }.store(in: &cancellable)

        wait(for: [expectation], timeout: 0.5)
        // Assert
        XCTAssertNotNil(response, "The response should not be nil in the case of valid data")
    }

    func testGitRepositoriesUseCase_WhenInvalidResponse_ShouldReturnError() {
        // Arrange
        MockURLProtocol.stubResponseData = nil
        let expectation = expectation(description: "repository success response expectation")
        var responseError: NetworkError!

        // Act
        sut.fetchGitRepositories(request: requestModel).sink { completion in
            switch completion {
            case let .failure(error):
                responseError = error
                expectation.fulfill()
            default:
                expectation.fulfill()
            }
        } receiveValue: { (_: [Repository]) in
        }.store(in: &cancellable)

        wait(for: [expectation], timeout: 0.5)
        // Assert
        XCTAssertNotNil(responseError, "The error should be happen in the case of invalid reponse")
        XCTAssertEqual(responseError, NetworkError.inValidResponse, "The invalid reponse should be thrown")
    }
}
