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
    case hideLoading
    case showRepositories
    case showError
}

protocol GitRepositoriesViewModelProtocol {
    init(useCase: GitRepositoriesUseCaseProtocol)
    var title: String { get }
    var numberOfSections: Int { get }
    var numberOfRows: Int { get }
    var stateDidUpdate: AnyPublisher<GitRepositoriesViewModelViewState, Never> { get }
    func fetchRepositories()
    func cellViewModelAtIndex(index: Int) -> GitRepositoryCellViewModel?
}

final class GitRepositoriesViewModel: GitRepositoriesViewModelProtocol {
    // MARK: - Private Properties
    private let useCase: GitRepositoriesUseCaseProtocol
    private let stateDidUpdateSubject = PassthroughSubject<GitRepositoriesViewModelViewState, Never>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    private var repositories: [Repository] = [Repository]()
    
    // MARK: - Public Properties
    private(set) lazy var stateDidUpdate: AnyPublisher<GitRepositoriesViewModelViewState, Never>  = stateDidUpdateSubject.eraseToAnyPublisher()
    
    var title: String {
        return "Trending"
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return repositories.count
    }
    
    // MARK: - init
    init(useCase: GitRepositoriesUseCaseProtocol = GitRepositoriesUseCase()) {
        self.useCase = useCase
    }
    
    func fetchRepositories() {
        stateDidUpdateSubject.send(.loading)
        useCase.fetchGitRepositories(request: GitRepositoriesRequest(search: "language=+sort:stars"))
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure( _ ):
                    self.stateDidUpdateSubject.send(.showError)
                default:
                    self.stateDidUpdateSubject.send(.hideLoading)
                }
            } receiveValue: { [weak self] repositories in
                guard let self = self else { return }
                self.repositories = repositories
                self.stateDidUpdateSubject.send(.showRepositories)
            }.store(in: &cancellable)
        
    }
    
    func cellViewModelAtIndex(index: Int) -> GitRepositoryCellViewModel? {
        if repositories.count > index {
            return GitRepositoryCellViewModel(repository: repositories[index])
        }
        return nil
    }
}
