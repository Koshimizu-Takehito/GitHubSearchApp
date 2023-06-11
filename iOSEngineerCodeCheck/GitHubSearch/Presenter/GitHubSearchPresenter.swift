//
//  GitHubSearchPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import class UIKit.UIImage

final class GitHubSearchPresenter {
    private weak var view: GitHubSearchView?
    private let interactor: GitHubSearchInputUsecase
    private let router: GitHubSearchWireFrame
    private let imageLoadable: ImageManaging
    private var order: StarSortingOrder?
    private var word: String = ""

    private var items: [Item] = []
    private var task: Task<Void, Never>?

    init(
        view: GitHubSearchView,
        interactor: GitHubSearchInputUsecase,
        router: GitHubSearchWireFrame,
        imageLoadable: ImageManaging = ImageManager()
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.imageLoadable = imageLoadable
    }
}
// MARK: - GitHubSearchPresentationプロトコルに関する -
extension GitHubSearchPresenter: GitHubSearchPresentation {
    var numberOfRow: Int {
        items.count
    }

    /// 検索ボタンのタップを検知。 GitHubデータのリセット。ローディングの開始。GitHubデータの取得を通知。
    func searchButtonDidPush(word: String) {
        guard let view else { return }
        self.items = []
        self.word = word
        view.resetDisplay()
        view.startLoading()
        fetch()
    }

    /// テキスト変更を検知。GitHubデータと画面の状態をリセット。タスクのキャンセル
    func searchTextDidChange() {
        guard let view else { return }
        task?.cancel()
        items = []
        word = ""
        view.resetDisplay()
    }

    /// セルタップの検知。DetailVCへ画面遷移通知。
    func didSelectRow(at index: Int) {
        let item = items[index]
        router.showGitHubDetailViewController(item: item)
    }

    /// スター数順の変更ボタンのタップを検知。(スター数で降順・昇順を切り替え)
    func starOderButtonDidPush() {
        guard let view else { return }
        items = []
        order.toggle()
        view.configure(order: order)
        view.startLoading()
        fetch()
    }

    func item(at index: Int) -> GitHubSearchViewItem {
        let item = items[index]
        let image = imageLoadable.cacheImage(forKey: item.owner.avatarUrl)
        return GitHubSearchViewItem(item: item, image: image)
    }

    func fetchImage(at index: Int) {
        Task { [weak self, weak view, loadable = imageLoadable, items] in
            let item = items[index]
            // 取得済みの場合はサムネイル取得処理をスキップ
            guard loadable.cacheImage(forKey: item.owner.avatarUrl) == nil else {
                return
            }
            // サムネイル取得処理を実行
            let image = (try? await loadable.loadImage(with: item.owner.avatarUrl)) ?? Asset.Images.untitled.image
            // 取得完了時の該当インデックスを探索
            guard let index = self?.items.firstIndex(where: { $0.id == item.id }) else {
                return
            }
            // ビューを更新
            let viewItem = GitHubSearchViewItem(item: item, image: image)
            view?.configure(item: viewItem, at: index)
        }
    }
}

private extension GitHubSearchPresenter {
    func fetch() {
        task = Task { [interactor, word, order, weak view, weak self] in
            switch await interactor.fetch(word: word, order: order) {
            case .success(let items) where items.isEmpty:
                view?.showEmptyMessage()
            case .success(let items):
                self?.items = items
                view?.reloadTableView()
            case .failure(let error):
                view?.showErrorAlert(error: error)
            }
        }
    }
}

// MARK: - StarSortingOrder
private extension Optional<StarSortingOrder> {
    mutating func toggle() {
        switch self {
        case .none:
            self = .desc
        case .desc:
            self = .asc
        case .asc:
            self = .none
        }
    }
}
