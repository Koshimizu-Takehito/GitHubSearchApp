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
    private let router: any GitHubDetailRouting
    private let useCase: any GitHubDetailUseCase
    private let imageManager: any ImageManaging

    init(
        id: ItemID,
        view: (any GitHubDetailView)? = nil,
        router: any GitHubDetailRouting,
        useCase: any GitHubDetailUseCase,
        imageManager: any ImageManaging
    ) {
        self.id = id
        self.view = view
        self.router = router
        self.useCase = useCase
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
