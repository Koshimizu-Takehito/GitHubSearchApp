//
//  GitHubDetailRouter.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubDetailRouter {
    private weak var viewController: UIViewController?

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension GitHubDetailRouter: GitHubDetailRouting {
    static func assembleModules(id: ItemID) -> UIViewController {
        let view = StoryboardScene.GitHubDetail.initialScene.instantiate()
        let router = GitHubDetailRouter(viewController: view)
        @Injected var useCase: any GitHubDetailUseCase
        @Injected var imageManager: any ImageManaging
        view.presenter = GitHubDetailPresenter(
            id: id,
            view: view,
            router: router,
            useCase: useCase,
            imageManager: imageManager
        )
        return view
    }

    func showGitHubPage(url: URL) {
        UIApplication.shared.open(url)
    }
}
