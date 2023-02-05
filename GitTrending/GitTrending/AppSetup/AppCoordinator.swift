//
//  AppCoordinator.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import UIKit

public protocol AppCoordinatorProtocol: Coordinator {
    init(window: UIWindow, navigation: UINavigationController)
}

final class AppCoordinator: AppCoordinatorProtocol {
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
        let gitRepositoriesCoordinator = GitSearchRepositoriesCoordinator(navigationController: navigation)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        gitRepositoriesCoordinator.start()
    }
}
