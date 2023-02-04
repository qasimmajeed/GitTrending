//
//  GitRepositoriesViewController.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import UIKit
import Combine

class GitRepositoriesViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    private let viewModel: GitRepositoriesViewModelProtocol
    private var cancellable = Set<AnyCancellable>()
    
    
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
        binding()
        viewModel.fetchRepositories()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        self.tableView.register(UINib(nibName: GitRepositoryTableViewCell.reuseAbleCellIdentifier, bundle: nil), forCellReuseIdentifier: GitRepositoryTableViewCell.reuseAbleCellIdentifier)
        title = viewModel.title
    }
    
    private func binding() {
        viewModel.stateDidUpdate.sink { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellable)
    }
}

extension GitRepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GitRepositoryTableViewCell.reuseAbleCellIdentifier) as? GitRepositoryTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.cellViewModelAtIndex(index: indexPath.row)
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
}
