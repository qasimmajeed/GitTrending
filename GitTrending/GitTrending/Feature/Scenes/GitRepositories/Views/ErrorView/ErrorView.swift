//
//  ErrorView.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 05/02/2023.
//

import UIKit
import Lottie

public final class ErrorView: UIView {
    // MARK: - Properties
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var someThingWrongLabel: UILabel!
    @IBOutlet weak var errorDetailLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    // MARK: - Methods
    class func loadViewFromXib() -> ErrorView? {
        return UINib(nibName: "ErrorView", bundle: Bundle(for: ErrorView.self)).instantiate(withOwner: self, options: nil)[0] as? ErrorView
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        self.retryButton.layer.borderWidth = 1.0
        self.retryButton.layer.borderColor = UIColor(named: "greenColor")?.cgColor
        self.retryButton.tintColor = UIColor(named: "greenColor")
        self.retryButton.layer.cornerRadius = 5.0
    }
}
