//
//  GitRepositoriesCoordinator.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import UIKit

protocol GitRepositoriesCoordinatorProtocol: Coordinator {}

struct GitRepositoriesCoordinator: GitRepositoriesCoordinatorProtocol {
    // MARK: - Private Properties

    private let navigationController: UINavigationController
    private let factory: GitRepositoriesViewControllerFactoryProtocol

    // MARK: - init

    init(navigationController: UINavigationController, factory: GitRepositoriesViewControllerFactoryProtocol = GitRepositoriesViewControllerFactory()) {
        self.navigationController = navigationController
        self.factory = factory
    }

    // MARK: - Coordinator Implementation

    func start() {
        let respositoriesViewController = factory.makeGitRepositoriesViewController()
        navigationController.setViewControllers([respositoriesViewController], animated: true)
    }
}
