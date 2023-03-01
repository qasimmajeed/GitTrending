//
//  ErrorView.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import Lottie
import UIKit

final class ErrorView: UIView {
    // MARK: - Properties

    @IBOutlet var animationView: LottieAnimationView!
    @IBOutlet var someThingWrongLabel: UILabel!
    @IBOutlet var errorDetailLabel: UILabel!
    @IBOutlet var retryButton: UIButton!

    // MARK: - Methods

    class func loadViewFromXib() -> ErrorView? {
        return UINib(nibName: "ErrorView", bundle: Bundle(for: ErrorView.self)).instantiate(withOwner: self, options: nil)[0] as? ErrorView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        retryButton.layer.borderWidth = 1.0
        retryButton.layer.borderColor = UIColor(named: "greenColor")?.cgColor
        retryButton.tintColor = UIColor(named: "greenColor")
        retryButton.layer.cornerRadius = 5.0
    }
}
