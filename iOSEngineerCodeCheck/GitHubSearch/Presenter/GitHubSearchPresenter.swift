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
    private let usecase: GitHubSearchInputUsecase
    private let router: GitHubSearchWireFrame
    private let imageLoadable: ImageManaging
    private var order: StarSortingOrder?
    private var word: String = ""

    private var items: [Item] = [] // TODO: 削除
    private var task: (any Cancelable)?

    init(
        view: GitHubSearchView,
        usecase: GitHubSearchInputUsecase,
        wireFrame: GitHubSearchWireFrame,
        imageLoadable: ImageManaging = ImageManager()
    ) {
        self.view = view
        self.usecase = usecase
        self.router = wireFrame
        self.imageLoadable = imageLoadable
    }
}
// MARK: - GitHubSearchPresentation
extension GitHubSearchPresenter: GitHubSearchPresentation {
    func didTapSearchButton(word: String) async {
        guard let view else { return }
        self.task?.cancel()
        self.items = []
        self.word = word
        await view.configure(item: .loading)
        fetch()
    }

    func didClearSearchText() async {
        task?.cancel()
        items = []
        word = ""
        await view?.configure(item: .initial)
    }

    func didSelectRow(at index: Int) async {
        let item = items[index]
        router.showGitHubDetailViewController(item: item)
    }

    func didTapStarOderButton() async {
        task?.cancel()
        items = []
        order.toggle()
        await view?.configure(order: .init(order))
        await view?.configure(item: .loading)
        fetch()
    }

    func willDisplayRow(at index: Int) async {
        let item = items[index]
        guard imageLoadable.cacheImage(forKey: item.owner.avatarUrl) == nil else { return }
        let image = (try? await imageLoadable.loadImage(with: item.owner.avatarUrl)) ?? Asset.Images.untitled.image
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        let viewItem = GitHubSearchViewItem.TableRow(item: item, image: image)
        await view?.configure(row: viewItem, at: index)
    }
}

private extension GitHubSearchPresenter {
    func fetch() {
        task = Task { [usecase, imageLoadable, word, order, weak view, weak self] in
            switch await usecase.fetch(word: word, order: order) {
            case .success(let items) where items.isEmpty:
                await view?.configure(item: .empty)
            case .success(let items):
                self?.items = items
                await view?.configure(item: .list(items: items, imageLoader: imageLoadable))
            case .failure(let error):
                await view?.showErrorAlert(error: error)
            }
        }
    }
}

// MARK: - StarSortingOrder
private extension StarSortingOrder? {
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
