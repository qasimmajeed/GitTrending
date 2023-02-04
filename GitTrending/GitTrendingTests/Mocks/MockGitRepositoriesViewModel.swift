//
//  MockGitRepositoriesViewModel.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Foundation
import Combine
@testable import GitTrending

final class MockGitRepositoriesViewModel: GitRepositoriesViewModelProtocol {
    
    // MARK: - Private Properties
    private var cancellable = Set<AnyCancellable>()
    private let stateDidUpdateSubject = PassthroughSubject<GitRepositoriesViewModelViewState, Never>()
    private let useCase: GitRepositoriesUseCaseProtocol
    private var repositories: [Repository] = [Repository]()
    
    init(useCase: GitRepositoriesUseCaseProtocol) {
        self.useCase = useCase
    }
    
    var title: String {
        return FakeGitRepositoryData.fakeTitle
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return repositories.count
    }
    
    private(set) lazy var stateDidUpdate: AnyPublisher<GitRepositoriesViewModelViewState, Never> = stateDidUpdateSubject.eraseToAnyPublisher()
    
    
    func fetchRepositories() {
        useCase.fetchGitRepositories(request: GitRepositoriesRequest(search: "")).sink { _ in
           
        } receiveValue: { value in
            self.repositories = value
            self.stateDidUpdateSubject.send(.showRepositories)
            
        }.store(in: &cancellable)
        
    }
}
