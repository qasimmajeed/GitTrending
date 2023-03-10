//
//  GitRepositoriesViewModel.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Combine

/// State for the ViewModel
enum GitRepositoriesViewModelViewState {
    case loading
    case hideLoading
    case showRepositories
    case showError
}

/// GitRepositoriesViewModelProtocol
protocol GitRepositoriesViewModelProtocol {
    var title: String { get }
    var refreshTitle: String { get }
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
    private var cancellable: Set<AnyCancellable> = .init()
    private var repositories: [Repository] = .init()
    private var cellViewModels: [GitRepositoryCellViewModel] = .init()

    // MARK: - Properties

    private(set) lazy var stateDidUpdate: AnyPublisher<GitRepositoriesViewModelViewState, Never> = stateDidUpdateSubject.eraseToAnyPublisher()

    var title: String {
        return "Trending"
    }

    var refreshTitle: String {
        return "Pull to refresh"
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

    // MARK: - Methods

    func fetchRepositories() {
        stateDidUpdateSubject.send(.loading)
        useCase.fetchGitRepositories(request: GitRepositoriesRequest(search: "language=+sort:stars"))
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure:
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

    func cellViewModelAtIndex(index: Int) -> GitRepositoryCellViewModel? {
        if cellViewModels.count > index {
            return cellViewModels[index]
        }
        return nil
    }

    func didSelectAtIndex(index: Int) {
        if cellViewModels.count > index {
            cellViewModels[index].isExpanded.toggle()
            stateDidUpdateSubject.send(.showRepositories)
        }
    }

    func retryFetch() {
        fetchRepositories()
    }

    func fetchFromPullToRefresh() {
        fetchRepositories()
    }
}
