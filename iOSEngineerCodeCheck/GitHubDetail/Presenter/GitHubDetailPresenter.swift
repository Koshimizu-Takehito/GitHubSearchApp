//
//  GitHubDetailPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

actor GitHubDetailPresenter: GitHubDetailPresentation {
    private let id: ItemID
    private weak var view: (any GitHubDetailView)?
    private let useCase: any GitHubDetailUseCase
    private let router: any GitHubDetailRouting
    private let imageManager: any ImageManaging

    init(
        id: ItemID,
        view: any GitHubDetailView,
        useCase: any GitHubDetailUseCase,
        router: any GitHubDetailRouting,
        imageManager: any ImageManaging
    ) {
        self.id = id
        self.view = view
        self.useCase = useCase
        self.router = router
        self.imageManager = imageManager
    }

    func viewDidLoad() async {
        guard let item = await useCase.cached(for: id) else {
            return
        }
        let image = imageManager.cachedImage(forKey: item.owner.avatarUrl)
        await view?.configure(item: .init(item: item, avatarImage: image))
    }

    func safariButtoDidPush() async {
        guard let item = await useCase.cached(for: id) else {
            return
        }
        await router.showGitHubPage(url: item.owner.htmlUrl)
    }
}
