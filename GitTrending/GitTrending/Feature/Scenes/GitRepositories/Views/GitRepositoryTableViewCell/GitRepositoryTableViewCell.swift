//
//  GitRepositoryTableViewCell.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Kingfisher
import UIKit

final class GitRepositoryTableViewCell: UITableViewCell {
    // MARK: - Properties

    static var reuseAbleCellIdentifier: String = "GitRepositoryTableViewCell"
    static var nibName: String = "GitRepositoryTableViewCell"

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var repositoryNameLabel: UILabel!
    @IBOutlet var repositoryLinkLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var starCountLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var starImageView: UIImageView!
    @IBOutlet var languageFlagView: UIView!
    @IBOutlet var expandedUIStackView: UIStackView!

    var viewModel: GitRepositoryCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                userNameLabel.text = viewModel.userName
                repositoryNameLabel.text = viewModel.repoName
                repositoryLinkLabel.text = viewModel.repoHtmlURl
                languageLabel.text = viewModel.language
                starCountLabel.text = viewModel.starCount
                expandedUIStackView.isHidden = !viewModel.isExpanded
                profileImageView.kf.setImage(with: viewModel.profileImageURL)
            }
        }
    }

    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private Methods

    private func setupUI() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        languageFlagView.layer.cornerRadius = languageFlagView.bounds.height / 2

        expandedUIStackView.isAccessibilityElement = true
        expandedUIStackView.accessibilityIdentifier = "expandedView"
    }
}
