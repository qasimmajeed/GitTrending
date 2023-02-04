//
//  Owner.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import Foundation

struct Owner: Decodable {
  let id: Int
  let login: String
  let avatarUrl: String

  enum CodingKeys: String, CodingKey {
    case id, login
    case avatarUrl = "avatar_url"
  }
}
