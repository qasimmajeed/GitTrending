//
//  GitRepositoriesViewModel.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Foundation
import Combine

public enum GitRepositoriesViewModelViewState {
    case loading
    case showRepositories
}

final class GitRepositoriesViewModel {
    // MARK: - Private Properties
    private let useCase: GitRepositoriesUseCaseProtocol
    private let stateDidUpdateSubject = PassthroughSubject<GitRepositoriesViewModelViewState, Never>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Public Properties
    private(set) lazy var stateDidUpdate: AnyPublisher<GitRepositoriesViewModelViewState, Never>  = stateDidUpdateSubject.eraseToAnyPublisher()
    
    // MARK: - init
    init(useCase: GitRepositoriesUseCaseProtocol = GitRepositoriesUseCase()) {
        self.useCase = useCase
    }
    
    func fetchRepositories() {
        stateDidUpdateSubject.send(.loading)
        useCase.fetchGitRepositories(request: GitRepositoriesRequest(search: "", language: "+sort:stars"))
            .sink {  completion in
                
            } receiveValue: { [weak self] repositories in
                guard let self = self else { return }
                self.stateDidUpdateSubject.send(.showRepositories)
                
            }.store(in: &cancellable)
        
    }
}
