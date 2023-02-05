//
//  GitRepositoriesViewModel.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Foundation
import Combine

/// State for the ViewModel
public enum GitRepositoriesViewModelViewState {
    case loading
    case hideLoading
    case showRepositories
    case showError
}


/// GitRepositoriesViewModelProtocol
protocol GitRepositoriesViewModelProtocol {
    init(useCase: GitRepositoriesUseCaseProtocol)
    var title: String { get }
    var numberOfSections: Int { get }
    var numberOfRows: Int { get }
    var stateDidUpdate: AnyPublisher<GitRepositoriesViewModelViewState, Never> { get }
    func fetchRepositories()
    func cellViewModelAtIndex(index: Int) -> GitRepositoryCellViewModel?
    func didSelectAtIndex(index: Int)
    func retryFetch()
    func fetchFromPullToRefresh()
}

final class GitRepositoriesViewModel: GitRepositoriesViewModelProtocol {
    // MARK: - Private Properties
    private let useCase: GitRepositoriesUseCaseProtocol
    private let stateDidUpdateSubject = PassthroughSubject<GitRepositoriesViewModelViewState, Never>()
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    private var repositories: [Repository] = [Repository]()
    private var cellViewModels: [GitRepositoryCellViewModel] = [GitRepositoryCellViewModel]()
    
    // MARK: - Public Properties
    private(set) lazy var stateDidUpdate: AnyPublisher<GitRepositoriesViewModelViewState, Never>  = stateDidUpdateSubject.eraseToAnyPublisher()
    
    public var title: String {
        return "Trending"
    }
    
    public var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return repositories.count
    }
    
    // MARK: - init
    public init(useCase: GitRepositoriesUseCaseProtocol = GitRepositoriesUseCase()) {
        self.useCase = useCase
    }
    
    // MARK: - Methods
    public func fetchRepositories() {
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
                self.cellViewModels = self.repositories.map { GitRepositoryCellViewModel(repository: $0) }
                self.stateDidUpdateSubject.send(.showRepositories)
            }.store(in: &cancellable)
        
    }
    
    public func cellViewModelAtIndex(index: Int) -> GitRepositoryCellViewModel? {
        if cellViewModels.count > index {
            return cellViewModels[index]
        }
        return nil
    }
    
    public func didSelectAtIndex(index: Int) {
        if cellViewModels.count > index {
            cellViewModels[index].isExpanded.toggle()
            self.stateDidUpdateSubject.send(.showRepositories)
        }
    }
    
    public func retryFetch() {
        fetchRepositories()
    }
    
    public func fetchFromPullToRefresh() {
        fetchRepositories()
    }
}
