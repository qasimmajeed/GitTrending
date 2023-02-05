//
//  GitRepositoriesViewController.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import UIKit
import Combine
import SkeletonView

final class GitRepositoriesViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var errorView: ErrorView?
    private let viewModel: GitRepositoriesViewModelProtocol
    private var cancellable = Set<AnyCancellable>()
    private lazy var pullToRefresh : UIRefreshControl = {
      let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refresh
    }()
    
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
        tableView.isSkeletonable = true
        tableView.estimatedRowHeight = 100
        self.tableView.register(UINib(nibName: GitRepositoryTableViewCell.reuseAbleCellIdentifier, bundle: nil), forCellReuseIdentifier: GitRepositoryTableViewCell.reuseAbleCellIdentifier)
        title = viewModel.title
        tableView.addSubview(pullToRefresh)
        pullToRefresh.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
    }
    
    private func binding() {
        viewModel.stateDidUpdate.sink { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.removeErrorView()
                switch state {
                case .showError:
                    self.showErrorView()
                case .loading:
                    self.tableView.showAnimatedGradientSkeleton()
                case .hideLoading:
                    self.tableView.stopSkeletonAnimation()
                    self.tableView.hideSkeleton()
                case .showRepositories:
                    self.pullToRefresh.endRefreshing()
                }
            }
        }.store(in: &cancellable)
    }
    
    private func showErrorView() {
        errorView = ErrorView.loadViewFromXib()
        if let errorView = errorView {
            errorView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(errorView)
            NSLayoutConstraint.activate([
                 errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                 errorView.topAnchor.constraint(equalTo: view.topAnchor),
                 errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
             ])
            errorView.retryButton.addTarget(self, action: #selector(retryButtonTap), for: .touchUpInside)
        }
        
    }
    
    private func removeErrorView() {
        guard let error = errorView else {
            return
        }
        error.removeFromSuperview()
    }
    
    @objc public func retryButtonTap() {
        viewModel.retryFetch()
    }
    
    @objc public func pullToRefreshAction() {
        viewModel.fetchFromPullToRefresh()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectAtIndex(index: indexPath.row)
    }
}

// MARK: - SkeletonTableViewDataSource
extension GitRepositoriesViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return GitRepositoryTableViewCell.reuseAbleCellIdentifier
    }
}
