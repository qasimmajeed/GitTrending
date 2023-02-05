//
//  UIStoryboard+Extensions.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import UIKit

extension UIStoryboard {
    /// Define all the storyboards name here
    enum Name: String {
        case gitRepositories = "GitRepositories"
    }
    
    convenience init(name: Name, bundle: Bundle? = nil) {
        self.init(name: name.rawValue, bundle: bundle)
    }
}
