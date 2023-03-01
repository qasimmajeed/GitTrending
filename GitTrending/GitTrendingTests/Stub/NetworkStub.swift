//
//  NetworkStub.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Foundation
import NetworkFeature
import TestingSupport

struct NetworkStub {
    static var stub: Networking {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        return Network(urlSession: session)
    }
}
