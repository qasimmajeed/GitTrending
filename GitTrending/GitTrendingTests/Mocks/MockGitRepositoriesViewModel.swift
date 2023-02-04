//
//  MockGitRepositoriesViewModel.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Foundation
import Combine
@testable import GitTrending

final class MockGitRepositoriesViewModel: GitRepositoriesViewModelProtocol {
    
    init(useCase: GitRepositoriesUseCaseProtocol) {}
    
    var title: String {
        return FakeGitRepositoryData.fakeTitle
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return FakeGitRepositoryData.fakeRepositories.count
    }
    
    var stateDidUpdate: AnyPublisher<GitRepositoriesViewModelViewState, Never> = PassthroughSubject<GitRepositoriesViewModelViewState, Never>().eraseToAnyPublisher()
    
    func fetchRepositories() {
        
    }
    
    
}
