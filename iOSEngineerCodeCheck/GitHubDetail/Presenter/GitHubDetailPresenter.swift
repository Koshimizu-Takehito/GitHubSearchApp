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
    @Injected var useCase: any GitHubDetailUseCase
    @Injected var imageManager: any ImageManaging

    init(id: ItemID, view: any GitHubDetailView, router: any GitHubDetailRouting) {
        self.id = id
        self.view = view
        self.router = router
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
