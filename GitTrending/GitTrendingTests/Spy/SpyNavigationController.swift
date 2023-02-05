//
//  SpyNavigationController.swift
//  GitTrendingTests
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import Foundation
import UIKit

final class SpyNavigationController: UINavigationController {
    // MARK: - Properties
    var controller: UIViewController!
    
    // MARK: - UINavigationController
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        self.controller = viewControllers.first
    }
}
