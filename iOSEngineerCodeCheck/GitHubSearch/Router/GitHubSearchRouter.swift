//
//  GitHubSearchRouter.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubSearchRouter {
    private weak var viewController: UIViewController?

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension GitHubSearchRouter: GitHubSearchWireFrame {
    static func assembleModules() -> UIViewController {
        let view = StoryboardScene.GitHubSearch.initialScene.instantiate()
        let router = GitHubSearchRouter(viewController: view)
        view.presenter = GitHubSearchPresenter(
            view: view,
            usecase: GitHubSearchInteractor(),
            wireFrame: router,
            imageManaging: ImageManager()
        )
        return view
    }

    func showGitHubDetailViewController(item: Item) {
        let destination = GitHubDetailRouter.assembleModules(item: item)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
