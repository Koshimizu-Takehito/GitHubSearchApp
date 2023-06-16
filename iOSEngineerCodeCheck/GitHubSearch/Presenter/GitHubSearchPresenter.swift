//
//  GitHubSearchPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

final class GitHubSearchPresenter: GitHubSearchPresentation {
    private weak var view: GitHubSearchView?
    private let usecase: GitHubSearchInputUsecase
    private let router: GitHubSearchWireFrame
    private let imageManaging: ImageManaging
    private var order: StarSortingOrder?
    private var word = ""
    private var task: (any Cancelable)?

    init(view: GitHubSearchView, usecase: GitHubSearchInputUsecase, wireFrame: GitHubSearchWireFrame, imageManaging: ImageManaging) {
        self.view = view
        self.usecase = usecase
        self.router = wireFrame
        self.imageManaging = imageManaging
    }

    func didTapSearchButton(word: String) async {
        self.task?.cancel()
        self.word = word
        await view?.configure(item: .loading)
        fetch()
    }

    func didClearSearchText() async {
        self.word = ""
        await view?.configure(item: .initial)
    }

    func didSelectRow(at index: Int) async {
        let items = usecase.restore(word: word, order: order)
        await router.showGitHubDetailViewController(item: items[index])
    }

    func didTapStarOderButton() async {
        order.toggle()
        await view?.configure(item: .loading, order: .init(order))
        fetch()
    }

    func willDisplayRow(at index: Int) async {
        let items = usecase.restore(word: word, order: order)
        guard index < items.count else {
            return
        }
        let item = items[index]
        let url = item.owner.avatarUrl
        guard imageManaging.cacheImage(forKey: url) == nil else {
            return
        }
        let image = (try? await imageManaging.loadImage(with: url))
            ?? Asset.Images.untitled.image
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        await view?.configure(row: .init(item: item, image: image), at: index)
    }
}

// MARK: -
private extension GitHubSearchPresenter {
    func fetch() {
        task?.cancel()
        task = Task { [usecase, imageManaging, word, order, weak view] in
            switch await usecase.fetch(word: word, order: order) {
            case .success(let items) where items.isEmpty:
                await view?.configure(item: .empty)
            case .success(let items):
                await view?.configure(item: .list(items: items, cachable: imageManaging))
            case .failure(let error):
                await view?.showAlert(error: error)
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
