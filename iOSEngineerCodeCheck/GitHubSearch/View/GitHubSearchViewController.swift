//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/16.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubSearchViewController: UIViewController {
    var presenter: GitHubSearchPresentation!
    private lazy var dataSource = GitHubSearchTableViewDataSource(tableView: tableView)

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyDescriptionLabel: UILabel!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var starOderButton: UIButton! {
        didSet {
            starOderButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
            starOderButton.layer.cornerRadius = 8
            starOderButton.clipsToBounds = true
            starOderButton.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
}

private extension GitHubSearchViewController {
    private func setUp() {
        tableView.dataSource = dataSource
        configure(order: .none)
        configure(item: .initial)
        setupNavigationBar(title: "ホーム")
    }

    private func configure(order: Order) {
        starOderButton.setTitle(order.title, for: .normal)
        starOderButton.setBackgroundImage(order.image)
    }

    @IBAction private func starOrderButton(_ sender: Any) {
        guard indicatorView.isHidden else { return }
        Task { [weak presenter] in
            await presenter?.didTapStarOderButton()
        }
    }
}

// MARK: - GitHubSearchView
extension GitHubSearchViewController: GitHubSearchView {
    func configure(item: ViewItem, order: Order) {
        configure(item: item)
        configure(order: order)
    }

    func configure(item: ViewItem) {
        indicatorView.setIsAnimating(item.loading.isAnimating)
        emptyDescriptionLabel.isHidden = item.emptyDescription.isHidden
        if let items = item.table.items {
            dataSource.reload(with: items)
        }
    }

    func configure(row: TableRow, at index: Int) {
        dataSource.replace(item: row, at: index)
    }

    func showAlert(error: Error) {
        configure(item: .initial)
        presentAlertController(error: error)
    }
}

// MARK: - UISearchBarDelegate
extension GitHubSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            configure(item: .initial)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // テキストが空、もしくはローディング中はタップ無効。
        guard let text = searchBar.text, !text.isEmpty, indicatorView.isHidden else { return }
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        Task { [weak presenter] in
            await presenter?.didTapSearchButton(word: text)
        }
    }

    // キャンセルボタンを表示
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    // キャンセルボタンとキーボードを非表示。
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension GitHubSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Task { [weak presenter] in
            await presenter?.didSelectRow(at: indexPath.row)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        Task { [weak presenter] in
            await presenter?.willDisplayRow(at: indexPath.row)
        }
    }
}
