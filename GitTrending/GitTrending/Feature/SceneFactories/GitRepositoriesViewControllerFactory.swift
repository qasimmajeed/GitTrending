//
//  GitRepositoriesViewControllerFactory.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import UIKit

protocol GitRepositoriesViewControllerFactoryProtocol {
    func makeGitRepositoriesViewController() -> GitRepositoriesViewController
}

/// This class is responsible for creation of all the object related to GitRepositoriesViewController
public final class GitRepositoriesViewControllerFactory: GitRepositoriesViewControllerFactoryProtocol {
    // MARK: - Private Properties

    private let useCase: GitRepositoriesUseCaseProtocol

    // MARK: - Init

    init(useCase: GitRepositoriesUseCaseProtocol = GitRepositoriesUseCase()) {
        self.useCase = useCase
    }

    // MARK: - Public Methods

    func makeGitRepositoriesViewController() -> GitRepositoriesViewController {
        let storyboard = UIStoryboard(name: .gitRepositories, bundle: Bundle.main)
        let viewModel = GitRepositoriesViewModel(useCase: useCase)
        let viewController: GitRepositoriesViewController = storyboard.instantiateViewController(identifier: "GitRepositoriesViewController") {
            GitRepositoriesViewController(coder: $0, viewModel: viewModel)
        }
        return viewController
    }
}
