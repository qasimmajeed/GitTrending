//
//  ErrorView.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import UIKit

class ErrorView: UIView {
    class func loadViewFromXib() -> ErrorView? {
        return UINib(nibName: "ErrorView", bundle: Bundle(for: ErrorView.self)).instantiate(withOwner: self, options: nil)[0] as? ErrorView
    }
}
