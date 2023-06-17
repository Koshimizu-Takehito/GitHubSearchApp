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

extension GitHubDetailRouter: GitHubDetailWireFrame {
    // TODO: ItemID で復元できるようにする
    static func assembleModules(item: Item) -> UIViewController {
        let view = StoryboardScene.GitHubDetail.initialScene.instantiate()
        let router = GitHubDetailRouter(viewController: view)
        let presenter = GitHubDetailPresenter(
            item: item,
            view: view,
            router: router,
            viewItem: GitHubDetailViewItem(item: item)
        )
        view.presenter = presenter
        return view
    }
}
