//
//  GitRepositoriesViewControllerFactory.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import NetworkFeature
import TestingSupport
import UIKit

protocol GitRepositoriesViewControllerFactoryProtocol {
    func makeGitRepositoriesViewController() -> GitRepositoriesViewController
}

/// This class is responsible for creation of all the object related to GitRepositoriesViewController
final class GitRepositoriesViewControllerFactory: GitRepositoriesViewControllerFactoryProtocol {
    // MARK: - Private Properties

    private let useCase: GitRepositoriesUseCaseProtocol

    // MARK: - Init

    init(useCase: GitRepositoriesUseCaseProtocol = GitRepositoriesUseCase()) {
        self.useCase = useCase
    }

    // MARK: - Methods

    func makeGitRepositoriesViewController() -> GitRepositoriesViewController {
        let storyboard = UIStoryboard(name: .gitRepositories, bundle: Bundle.main)
        var viewModel: GitRepositoriesViewModel?

        #if DEBUG

            if ProcessInfo.processInfo.arguments.contains("ui-Testing") {
                let configuration = URLSessionConfiguration.ephemeral
                configuration.protocolClasses = [MockURLProtocol.self]
                let session = URLSession(configuration: configuration)
                let network = Network(urlSession: session)

                viewModel = GitRepositoriesViewModel(useCase: GitRepositoriesUseCase(network: network))

                if ProcessInfo.processInfo.arguments.contains("success") {
                    MockURLProtocol.stubResponseData = FakeApiData.jsonFakeData.data(using: .utf8)

                } else if ProcessInfo.processInfo.arguments.contains("error") {
                    MockURLProtocol.stubError = NetworkError.invalidRequest
                }
            }

        #else

            viewModel = GitRepositoriesViewModel()

        #endif

        let viewController: GitRepositoriesViewController = storyboard.instantiateViewController(identifier: "GitRepositoriesViewController") {
            GitRepositoriesViewController(coder: $0, viewModel: viewModel ?? GitRepositoriesViewModel())
        }
        return viewController
    }
}
