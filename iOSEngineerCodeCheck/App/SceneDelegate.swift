//
//  SceneDelegate.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        UINavigationBar.setUp()

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: GitHubSearchRouter.assembleModules())
        window.makeKeyAndVisible()
        self.window = window
    }
}
