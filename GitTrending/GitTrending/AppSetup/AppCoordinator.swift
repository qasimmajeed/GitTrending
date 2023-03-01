//
//  AppCoordinator.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {}

struct AppCoordinator: AppCoordinatorProtocol {
    // MARK: - Private Properties

    private let window: UIWindow
    private let navigation: UINavigationController

    // MARK: - Init

    init(window: UIWindow, navigation: UINavigationController) {
        self.window = window
        self.navigation = navigation
    }

    // MARK: - Coordinator

    func start() {
        let gitRepositoriesCoordinator = GitRepositoriesCoordinator(navigationController: navigation)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        gitRepositoriesCoordinator.start()
    }
}
