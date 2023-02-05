//
//  Repository.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Foundation

public struct Repository: Decodable {
    let id: Int
    let name: String
    let owner: Owner
    let stars: Int
    let language: String?
    let htmlURL: String

    enum CodingKeys: String, CodingKey {
        case id, name, owner
        case stars = "stargazers_count"
        case language
        case htmlURL = "html_url"
    }
}
