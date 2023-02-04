//
//  GitRepositoryTableViewCell.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import UIKit

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
    
    var viewModel: Repository? {
        didSet {
            if let viewModel = viewModel {
                userNameLabel.text = viewModel.owner.login
                repositoryNameLabel.text = viewModel.name
                repositoryLinkLabel.text = viewModel.htmlURL
                languageLabel.text = viewModel.language
                starCountLabel.text = "\(viewModel.stars)"
            }
        }
    }
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
