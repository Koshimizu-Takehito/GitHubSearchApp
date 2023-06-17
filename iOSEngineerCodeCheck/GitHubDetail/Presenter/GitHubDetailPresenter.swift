//
//  GitHubDetailPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

final class GitHubDetailPresenter {
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
}

extension GitHubDetailPresenter: GitHubDetailPresentation {
    func viewDidLoad() {
        view?.configure(
            item: viewItem,
            avatarUrl: item.owner.avatarUrl
        )
    }

    func safariButtoDidPush() {
        guard let url = URL(string: item.owner.htmlUrl) else { return }
        router.showGitHubPage(url: url)
    }
}
