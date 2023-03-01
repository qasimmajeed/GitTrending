//
//  GitRepositoriesViewController.swift
//  GitTrending
//
//  Created by Muhammad Qasim Majeed on 04/02/2023.
//

import Combine
import SkeletonView
import UIKit

final class GitRepositoriesViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var tableView: UITableView!
    var errorView: ErrorView?
    private let viewModel: GitRepositoriesViewModelProtocol
    private var cancellable = Set<AnyCancellable>()
    private lazy var pullToRefresh: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: viewModel.refreshTitle)
        return refresh
    }()

    // MARK: - Init

    init?(coder: NSCoder, viewModel: GitRepositoriesViewModelProtocol = GitRepositoriesViewModel()) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("viewModel(GitRepositoriesViewModel) must provided while initialisation")
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
        tableView.accessibilityIdentifier = "tableView"
        tableView.estimatedRowHeight = 100
        tableView.register(UINib(nibName: GitRepositoryTableViewCell.reuseAbleCellIdentifier, bundle: nil), forCellReuseIdentifier: GitRepositoryTableViewCell.reuseAbleCellIdentifier)
        title = viewModel.title
        tableView.addSubview(pullToRefresh)
        pullToRefresh.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
    }

    private func binding() {
        viewModel.stateDidUpdate.sink { [weak self] state in
            guard let self = self else { return }
            self.updateState(state: state)
        }.store(in: &cancellable)
    }

    private func showErrorView() {
        errorView = ErrorView.loadViewFromXib()
        errorView?.accessibilityIdentifier = "errorView"
        if let errorView = errorView {
            errorView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(errorView)
            NSLayoutConstraint.activate([
                errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                errorView.topAnchor.constraint(equalTo: view.topAnchor),
                errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
            errorView.retryButton.addTarget(self, action: #selector(retryButtonTap), for: .touchUpInside)
        }
    }

    private func updateState(state: GitRepositoriesViewModelViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
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
    }

    private func removeErrorView() {
        errorView?.removeFromSuperview()
    }

    @objc func retryButtonTap() {
        viewModel.retryFetch()
    }

    @objc func pullToRefreshAction() {
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

    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectAtIndex(index: indexPath.row)
    }
}

// MARK: - SkeletonTableViewDataSource

extension GitRepositoriesViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_: UITableView, cellIdentifierForRowAt _: IndexPath) -> ReusableCellIdentifier {
        return GitRepositoryTableViewCell.reuseAbleCellIdentifier
    }
}
