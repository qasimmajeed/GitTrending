//
//  GitRepositoryCellViewModel.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import Foundation

/// GitRepositoryCellViewModel
struct GitRepositoryCellViewModel {
    let id: Int
    let repoName: String
    let userName: String
    let profileImageURL: URL?
    let starCount: String
    let language: String?
    let repoHtmlURl: String
    var isExpanded: Bool
}

extension GitRepositoryCellViewModel {
    init(repository: Repository) {
        self.init(id: repository.id,
                  repoName: repository.name,
                  userName: repository.owner.login,
                  profileImageURL: URL(string: repository.owner.avatarUrl),
                  starCount: "\(repository.stars)",
                  language: repository.language,
                  repoHtmlURl: repository.htmlURL,
                  isExpanded: false)
    }
}
