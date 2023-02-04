//
//  GitRepositoriesViewController.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import UIKit

class GitRepositoriesViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private let viewModel: GitRepositoriesViewModelProtocol
    
    
    // MARK: - Init
    init?(coder: NSCoder, viewModel: GitRepositoriesViewModelProtocol = GitRepositoriesViewModel()) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("viewModel(GitSearchRepoViewModel) must provided while initialisation")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        title = viewModel.title
    }
}
