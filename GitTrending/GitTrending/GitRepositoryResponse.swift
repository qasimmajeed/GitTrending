//
//  GitRepositoryResponse.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Foundation

struct GitRepositoryResponse: Decodable {
    let items: [Repository]
}
