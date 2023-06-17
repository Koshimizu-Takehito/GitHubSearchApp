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
    private weak var view: GitHubDetailView?
    private let useCase: GitHubDetailUseCase
    private let router: GitHubDetailRouter

    init(id: ItemID, view: GitHubDetailView, useCase: GitHubDetailUseCase, router: GitHubDetailRouter) {
        self.id = id
        self.view = view
        self.useCase = useCase
        self.router = router
    }

    func viewDidLoad() async {
        guard let item = await useCase.cached(for: id) else {
            return
        }
        let viewItem = GitHubDetailViewItem(item: item)
        await view?.configure(item: viewItem, avatarUrl: item.owner.avatarUrl)
    }

    func safariButtoDidPush() async {
        guard let item = await useCase.cached(for: id) else {
            return
        }
        await router.showGitHubPage(url: item.owner.htmlUrl)
    }
}
