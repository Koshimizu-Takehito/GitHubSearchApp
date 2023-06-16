//
//  UIViewController+Extension.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    ///  API通信。失敗した場合のエラーのアラート
    @MainActor
    func presentAlertController(error: Error) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }

    /// GitHubSearchViewControllerで使用する
    func setupNavigationBar(title: String, fontSize: CGFloat = 18) {
        navigationItem.title = title

        navigationItem.backBarButtonItem =
            UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.1089240834, green: 0.09241241962, blue: 0.1406958103, alpha: 1)
        appearance.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: fontSize, weight: .bold),
                .foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }

    /// GitHubDetailViewControllerで使用する
    func setupNavigationBar(title: String, fontSize: CGFloat = 18, buttonImage: UIImage, rightBarButtonAction: Selector) {
        navigationItem.title = title

        navigationItem.backBarButtonItem =
            UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white

        navigationItem.rightBarButtonItem =
            UIBarButtonItem(
            title: "",
            style: .done,
            target: self,
            action: rightBarButtonAction)
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.image = buttonImage

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.1089240834, green: 0.09241241962, blue: 0.1406958103, alpha: 1)
        appearance.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: fontSize, weight: .bold),
                .foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}
