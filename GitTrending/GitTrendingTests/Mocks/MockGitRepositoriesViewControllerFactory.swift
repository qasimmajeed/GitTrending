//
//  MockGitRepositoriesViewControllerFactory.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import Foundation
import UIKit
@testable import GitTrending

final class MockGitRepositoriesViewControllerFactory: GitRepositoriesViewControllerFactoryProtocol {
    // MARK: - Private Properties
    private let useCase: GitRepositoriesUseCaseProtocol
    
    // MARK: - Init
    init(useCase: GitRepositoriesUseCaseProtocol = MockRepositoriesUseCases(network: NetworkStub.stub) ) {
        self.useCase = useCase
    }
    
    // MARK: - Public Methods
    func makeGitRepositoriesViewController() -> GitRepositoriesViewController {
        let storyboard = UIStoryboard(name: .gitRepositories, bundle: Bundle.main)
        let viewModel = MockGitRepositoriesViewModel(useCase: useCase)
        let viewController: GitRepositoriesViewController = storyboard.instantiateViewController(identifier: "GitRepositoriesViewController") {
            GitRepositoriesViewController(coder: $0, viewModel: viewModel)
            
        }
        return viewController
    }
}
