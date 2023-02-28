//
//  MockGitRepositoriesViewModel.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Combine
import Foundation
@testable import GitTrending
import XCTest

final class MockGitRepositoriesViewModel: GitRepositoriesViewModelProtocol {
    // MARK: - Private Properties

    private var cancellable = Set<AnyCancellable>()
    private let stateDidUpdateSubject = PassthroughSubject<GitRepositoriesViewModelViewState, Never>()
    private let useCase: GitRepositoriesUseCaseProtocol
    private var repositories: [Repository] = .init()
    var expectation: XCTestExpectation?
    var isError: Bool = false
    var isRetryCalled: Bool = false
    var isPullToRefreshCalled: Bool = false

    init(useCase: GitRepositoriesUseCaseProtocol) {
        self.useCase = useCase
    }

    var title: String {
        return FakeGitRepositoryData.fakeTitle
    }
    

    var numberOfSections: Int {
        return 1
    }
    
    var refreshTitle: String {
        return "Pull to refresh"
    }

    var numberOfRows: Int {
        return repositories.count
    }

    private(set) lazy var stateDidUpdate: AnyPublisher<GitRepositoriesViewModelViewState, Never> = stateDidUpdateSubject.eraseToAnyPublisher()

    func fetchRepositories() {
        useCase.fetchGitRepositories(request: GitRepositoriesRequest(search: "")).sink { completion in
            switch completion {
            case .failure:
                self.isError = true
                self.stateDidUpdateSubject.send(.showError)
                self.expectation?.fulfill()
            default:
                self.expectation?.fulfill()
            }
        } receiveValue: { value in
            self.repositories = value
            self.stateDidUpdateSubject.send(.showRepositories)
        }.store(in: &cancellable)
    }

    func cellViewModelAtIndex(index: Int) -> GitRepositoryCellViewModel? {
        if index < repositories.count {
            return GitRepositoryCellViewModel(repository: repositories[index])
        }
        return nil
    }

    func didSelectAtIndex(index _: Int) {
        // TODO:
    }

    func retryFetch() {
        isRetryCalled = true
    }

    func fetchFromPullToRefresh() {
        isPullToRefreshCalled = true
    }
}
