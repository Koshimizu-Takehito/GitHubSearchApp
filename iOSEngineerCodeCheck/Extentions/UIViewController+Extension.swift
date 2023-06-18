//
//  UIViewController+Extension.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    static func alert(_ error: Error) -> UIViewController {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        return alert
    }

    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }

    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}
