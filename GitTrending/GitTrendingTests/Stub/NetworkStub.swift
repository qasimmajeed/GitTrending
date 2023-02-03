//
//  NetworkStub.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Foundation
import NetworkFeature

final class NetworkStub {
    static var stub:  Networking {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [GitTrendingMockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        return Network(urlSession: session)
    }
}
