//
//  GitHubDetailPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

actor GitHubDetailPresenter: GitHubDetailPresentation {
    private weak var view: GitHubDetailView?
    private let router: GitHubDetailRouter!
    private let viewItem: GitHubDetailViewItem!
    private let item: Item

    init(
        item: Item,
        view: GitHubDetailView,
        router: GitHubDetailRouter,
        viewItem: GitHubDetailViewItem) {
        self.item = item
        self.view = view
        self.router = router
        self.viewItem = viewItem
    }

    func viewDidLoad() async {
        await view?.configure(
            item: viewItem,
            avatarUrl: item.owner.avatarUrl
        )
    }

    func safariButtoDidPush() async {
        guard let url = URL(string: item.owner.htmlUrl) else { return }
        await router.showGitHubPage(url: url)
    }
}
