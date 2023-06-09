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
    private let imageLoadable: AvatarImageLoadable
    private var orderType: Order = .default
    private var word: String = ""

    private var items: [Item] = []

    init(
        view: GitHubSearchView,
        interactor: GitHubSearchInputUsecase,
        router: GitHubSearchWireFrame,
        imageLoadable: AvatarImageLoadable = AvatarImageLoader()
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

    func viewDidLoad() {
        view?.configure()
    }

    /// 検索ボタンのタップを検知。 GitHubデータのリセット。ローディングの開始。GitHubデータの取得を通知。
    func searchButtonDidPush(word: String) {
        reset()
        self.word = word
        view?.resetDisplay()
        view?.startLoading()
        interactor.fetch(word: word, orderType: orderType)
    }

    /// テキスト変更を検知。GitHubデータと画面の状態をリセット。タスクのキャンセル
    func searchTextDidChange() {
        word = ""
        reset()
        view?.resetDisplay()
        interactor.apiManager.task?.cancel()
    }

    /// セルタップの検知。DetailVCへ画面遷移通知。
    func didSelectRow(at index: Int) {
        let item = items[index]
        router.showGitHubDetailViewController(item: item)
    }

    /// スター数順の変更ボタンのタップを検知。(スター数で降順・昇順を切り替え)
    func starOderButtonDidPush() {
        changeStarOrder()
        fetchOrSetSearchOrderItem()
        view?.tableViewReload()
    }

    func item(at index: Int) -> GitHubSearchViewItem {
        let item = items[index]
        let image = imageLoadable.image(id: item.id)
        let viewItem = GitHubSearchViewItem(item: item, image: image)
        return viewItem
    }

    func fetchImage(at index: Int) {
        Task { [weak self, weak view, loadable = imageLoadable, items] in
            let item = items[index]
            // 取得済みの場合はサムネイル取得処理をスキップ
            guard loadable.image(id: item.id) == nil else {
                return
            }
            // サムネイル取得処理を実行
            let image = (try? await loadable.load(item: item)) ?? UIImage(named: "Untitled")
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

// MARK: - GitHubSearchOutputUsecase プロトコルに関する -
extension GitHubSearchPresenter: GitHubSearchOutputUsecase {
    /// GitHubリポジトリデータを各リポジトリ (デフォルト, 降順, 昇順) に保管しテーブルビューへ表示。
    func didFetchResult(result: Result<RepositoryItem, Error>) {
        view?.stopLoading()
        switch result {
        case .success(let item):
            setSearchOrderItem(item: item)
            view?.tableViewReload()
        case .failure(let error):
            setAppearError(error: error)
        }
    }
}

private extension GitHubSearchPresenter {
    /// 保管しているリポジトリのデータをリセット
    func reset() {
        items = []
    }

    ///  APIから取得したデータを各リポジトリへセット
    func setSearchOrderItem(item: RepositoryItem) {
        let items = item.items
        self.items = items
    }

    /// Starソート順のタイプとボタンの見た目を変更する
    func changeStarOrder() {
        self.orderType = orderType.next
        view?.didChangeStarOrder(searchItem: items, order: orderType)
    }

    /// もしリポジトリデータが空だった場合、APIからデータを取得する。データがすでにある場合はそれを使用する。
    func fetchOrSetSearchOrderItem() {
        items = []
        view?.startLoading()
        interactor.fetch(word: word, orderType: orderType)
    }

    /// API通信でエラーが返ってきた場合の処理
    func setAppearError(error: Error) {
        if error is ApiError {
            guard let apiError = error as? ApiError else { return }
            // 独自で定義したエラーを通知
            switch apiError {
            case .cancel: return
            case .notFound: view?.appearNotFound(message: apiError.errorDescription!)
            default: view?.appearErrorAlert(message: apiError.errorDescription!)
            }
        } else {
            //  標準のURLSessionのエラーを返す
            view?.appearErrorAlert(message: error.localizedDescription)
        }
    }
}

private extension Order {
    // 他の画面では異なる表示順にしたくなるかもなので、private extensionとした
    var next: Order {
        switch self {
        case .default:
            return .desc
        case .desc:
            return .asc
        case .asc:
            return .default
        }
    }
}
