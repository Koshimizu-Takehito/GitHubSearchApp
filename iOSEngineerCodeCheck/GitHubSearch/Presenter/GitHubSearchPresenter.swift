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
    private let imageLoadable: ImageManaging
    private var order: StarSortingOrder?
    private var word: String = ""
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
        router.showGitHubDetailViewController(item: items[index])
    }

    func didTapStarOderButton() async {
        order.toggle()
        await view?.configure(order: .init(order))
        await view?.configure(item: .loading)
        fetch()
    }

    func willDisplayRow(at index: Int) async {
        let items = usecase.restore(word: word, order: order)
        guard index < items.count else { return }
        let item = items[index]
        guard imageLoadable.cacheImage(forKey: item.owner.avatarUrl) == nil else { return }
        let image = (try? await imageLoadable.loadImage(with: item.owner.avatarUrl)) ?? Asset.Images.untitled.image
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        await view?.configure(row: .init(item: item, image: image), at: index)
    }
}

// MARK: -
private extension GitHubSearchPresenter {
    func fetch() {
        task?.cancel()
        task = Task { [usecase, imageLoadable, word, order, weak view] in
            switch await usecase.fetch(word: word, order: order) {
            case .success(let items) where items.isEmpty:
                await view?.configure(item: .empty)
            case .success(let items):
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
