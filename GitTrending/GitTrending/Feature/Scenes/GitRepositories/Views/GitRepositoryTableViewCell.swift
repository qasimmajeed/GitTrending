//
//  GitRepositoryTableViewCell.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import UIKit
import Kingfisher

class GitRepositoryTableViewCell: UITableViewCell {
    // MARK: - Properties
    static var reuseAbleCellIdentifier: String = "GitRepositoryTableViewCell"
    static var nibName: String = "GitRepositoryTableViewCell"
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var repositoryLinkLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var languageFlagView: UIView!
    @IBOutlet weak var expandedUIStackView: UIStackView!
    
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
    }
}
