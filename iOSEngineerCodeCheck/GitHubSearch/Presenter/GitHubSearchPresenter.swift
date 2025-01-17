//
//  GitHubSearchPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

actor GitHubSearchPresenter: GitHubSearchPresentation {
    private var task: (any Cancelable)?
    private var parameters = SearchParameters()
    private weak var view: (any GitHubSearchView)?
    private let router: any GitHubSearchRouting
    private let usecase: any GitHubSearchUseCase
    private let imageManager: any ImageManaging

    init(
        view: (any GitHubSearchView)? = nil,
        router: any GitHubSearchRouting,
        usecase: any GitHubSearchUseCase,
        imageManager: any ImageManaging
    ) {
        self.view = view
        self.router = router
        self.usecase = usecase
        self.imageManager = imageManager
    }

    func didTapSearchButton(word: String) async {
        guard parameters.word != word else { return }
        parameters.word = word
        await view?.configure(item: .loading)
        fetch()
    }

    func didSelectRow(at index: Int) async {
        let items = await usecase.cached(for: parameters)
        await router.showDetail(id: items[index].id)
    }

    func didTapStarOderButton() async {
        parameters.order.toggle()
        await view?.configure(item: .loading, order: .init(parameters.order))
        fetch()
    }

    func willDisplayRow(at index: Int) async {
        let items = await usecase.cached(for: parameters)
        guard index < items.count else {
            return
        }
        let item = items[index]
        let url = item.owner.avatarUrl
        guard imageManager.cachedImage(forKey: url) == nil else {
            return
        }
        let image = (try? await imageManager.loadImage(with: url))
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
        task = Task { [usecase, imageManager, parameters, weak view, weak router] in
            let result = await usecase.fetch(with: parameters)
            await MainActor.run { [weak view, weak router] in
                switch result {
                case .success(let items) where items.isEmpty:
                    view?.configure(item: .empty)
                case .success(let items):
                    view?.configure(item: .list(items: items, cachable: imageManager))
                case .failure(let error):
                    view?.configure(item: .initial)
                    router?.showAlert(error: error)
                }
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
