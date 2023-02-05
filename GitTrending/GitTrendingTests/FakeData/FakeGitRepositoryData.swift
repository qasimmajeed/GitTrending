//
//  FakeGitRepositoryData.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 03/02/2023.
//

import Foundation
import NetworkFeature
import TestingSupport
@testable import GitTrending

struct FakeGitRepositoryData {
    static let fakeTitle = "Trending"
    static let fakeRequest = ApiRequestBuilder(scheme: "http", host: Constants.APIUrls.baseURL, path: Constants.APIPaths.repositories, httpMethod: .Get)
    
    static let jsonFakeData = FakeApiData.jsonFakeData
}

