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

    private weak var view: GitHubSearchView?
    private let usecase: GitHubSearchInputUsecase
    private let wireFrame: GitHubSearchWireFrame
    private let imageManaging: ImageManaging

    init(view: GitHubSearchView, usecase: GitHubSearchInputUsecase, wireFrame: GitHubSearchWireFrame, imageManaging: ImageManaging) {
        self.view = view
        self.usecase = usecase
        self.wireFrame = wireFrame
        self.imageManaging = imageManaging
    }

    func didTapSearchButton(word: String) async {
        guard parameters.word != word else { return }
        parameters.word = word
        await view?.configure(item: .loading)
        fetch()
    }

    func didSelectRow(at index: Int) async {
        let items = await usecase.cached(for: parameters)
        await wireFrame.showDetail(item: items[index])
    }

    func didTapStarOderButton() async {
        parameters.order.toggle()
        await view?.configure(item: .loading, order: .init(parameters.order))
        fetch()
    }

    func willDisplayRow(at index: Int) async {
        // TODO: Github画像用のサービスクラスを実装する
        let items = await usecase.cached(for: parameters)
        guard index < items.count else {
            return
        }
        let item = items[index]
        let url = item.owner.avatarUrl
        guard imageManaging.cachedImage(forKey: url) == nil else {
            return
        }
        let image = (try? await imageManaging.loadImage(with: url))
            ?? Asset.Images.untitled.image
        guard let index = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        await view?.configure(
            row: .init(item: item, image: image),
            at: index
        )
    }
}

// MARK: -
private extension GitHubSearchPresenter {
    func fetch() {
        task?.cancel()
        task = Task { [usecase, imageManaging, parameters, weak view] in
            switch await usecase.fetch(with: parameters) {
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
