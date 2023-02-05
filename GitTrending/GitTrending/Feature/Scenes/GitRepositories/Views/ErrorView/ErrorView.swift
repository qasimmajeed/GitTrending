//
//  ErrorView.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import UIKit

class ErrorView: UIView {
    // MARK: - Properties
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var someThingWrongLabel: UILabel!
    @IBOutlet weak var errorDetailLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    // MARK: - Methods
    
    class func loadViewFromXib() -> ErrorView? {
        return UINib(nibName: "ErrorView", bundle: Bundle(for: ErrorView.self)).instantiate(withOwner: self, options: nil)[0] as? ErrorView
    }
}
