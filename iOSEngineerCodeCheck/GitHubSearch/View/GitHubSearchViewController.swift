//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubSearchViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyDescriptionLabel: UILabel!
    @IBOutlet private weak var frontView: UIView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var starOderButton: UIButton! {
        didSet {
            if #available(iOS 15.0, *) {
                starOderButton.configuration = nil
            }
            starOderButton.setTitle("☆ Star数 ", for: .normal)
            starOderButton.titleLabel?.font = .systemFont(
                ofSize: 16,
                weight: .semibold
            )
            starOderButton.layer.cornerRadius = 8
            starOderButton.clipsToBounds = true
            starOderButton.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }

    var presenter: GitHubSearchPresentation!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

private extension GitHubSearchViewController {
    @IBAction func starOrderButton(_ sender: Any) {
        guard indicatorView.isHidden else { return }
        presenter.starOderButtonDidPush()
    }
}

// MARK: - GitHubSearchViewプロトコルに関する -
extension GitHubSearchViewController: GitHubSearchView {
    /// 初期画面の構成
    func setUp() {
        indicatorView.isHidden = true
        searchBar.placeholder = "GitHub リポジトリを検索"
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        emptyDescriptionLabel.text = nil
        frontView.isHidden = true
        setupNavigationBar(title: "ホーム")
    }

    /// 画面の状態をリセットする
    func resetDisplay() {
        DispatchQueue.main.async { [self] in
            frontView.isHidden = true
            indicatorView.isHidden = true
            emptyDescriptionLabel.text = nil
            tableView.reloadData()
        }
    }

    /// ローディング中を表示
    func startLoading() {
        DispatchQueue.main.async { [self] in
            indicatorView.startAnimating()
            frontView.isHidden = false
            indicatorView.isHidden = false
        }
    }

    /// ローディング画面を停止
    func stopLoading() {
        DispatchQueue.main.async { [self] in
            indicatorView.stopAnimating()
            frontView.isHidden = true
            indicatorView.isHidden = true
        }
    }

    /// エラーアラートの表示
    func showErrorAlert(error: Error) {
        DispatchQueue.main.async { [self] in
            stopLoading()
            presentAlertController(error: error)
        }
    }

    /// GitHubデータの取得が0件の場合に表示
    func showEmptyMessage() {
        DispatchQueue.main.async { [self] in
            frontView.isHidden = false
            indicatorView.isHidden = true
            emptyDescriptionLabel.text = "結果が見つかりませんでした"
        }
    }

    func reloadTableView() {
        DispatchQueue.main.async { [self] in
            stopLoading()
            tableView.reloadData()
        }
    }

    func configure(item: GitHubSearchViewItem, at index: Int) {
        DispatchQueue.main.async { [tableView = tableView!] in
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? GitHubSearchTableViewCell {
                cell.configure(item: item)
            }
        }
    }

    /// ボタンの見た目を変更する
    func configure(order: StarSortingOrder?) {
        starOderButton.setTitle(order.text, for: .normal)
        starOderButton.backgroundColor = order.backgroundColor
    }
}

private extension Optional<StarSortingOrder> {
    var text: String {
        switch self {
        case .none:
            return "☆ Star数 "
        case .asc:
            return "☆ Star数 ⍒"
        case .desc:
            return "☆ Star数 ⍋"
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .none:
            return .lightGray
        case .asc:
            return #colorLiteral(red: 0.1634489, green: 0.1312818527, blue: 0.2882181406, alpha: 1)
        case .desc:
            return #colorLiteral(red: 0.1634489, green: 0.1312818527, blue: 0.2882181406, alpha: 1)
        }
    }
}

// MARK: - サーチボタンに関する -
extension GitHubSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let isEmptyText = searchBar.text?.isEmpty else { return }
        if isEmptyText {
            // テキストが空になった事を通知。テーブルビューをリセットするため。
            presenter.searchTextDidChange()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // テキストが空、もしくはローディング中はタップ無効。
        guard let text = searchBar.text, !text.isEmpty, indicatorView.isHidden else { return }
        // 検索ボタンのタップを通知。 GitHubデータを取得の指示。
        presenter.searchButtonDidPush(word: text)
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
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

extension GitHubSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRow
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GitHubSearchTableViewCell.identifier) as? GitHubSearchTableViewCell else { return UITableViewCell() } // swiftlint:disable:this all
        cell.selectionStyle = .none

        let item = presenter.item(at: indexPath.row)

        cell.configure(item: item)
        return cell
    }
}

extension GitHubSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルタップを通知。GitHubデータを渡してます。
        presenter.didSelectRow(at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.fetchImage(at: indexPath.row)
    }
}
