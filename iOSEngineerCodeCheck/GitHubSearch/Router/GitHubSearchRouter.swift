//
//  GitHubSearchRouter.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubSearchRouter: GitHubSearchRouting {
    private weak var viewController: UIViewController?

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    /// 検索画面のビューコントローラを生成
    static func assembleModules() -> UIViewController {
        let view = StoryboardScene.GitHubSearch.initialScene.instantiate()
        let router = GitHubSearchRouter(viewController: view)
        @Injected var usecase: any GitHubSearchUseCase
        @Injected var imageManager: any ImageManaging
        view.presenter = GitHubSearchPresenter(
            view: view,
            router: router,
            usecase: usecase,
            imageManager: imageManager
        )
        return view
    }

    func showDetail(id: ItemID) {
        let destination = GitHubDetailRouter.assembleModules(id: id)
        viewController?.push(destination)
    }

    func showAlert(error: Error) {
        viewController?.present(.alert(error))
    }
}
