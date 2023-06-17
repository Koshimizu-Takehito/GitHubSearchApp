//
//  GitHubSearchRouting.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import class UIKit.UIViewController

// MARK: - Router
/// Router
@MainActor
protocol GitHubSearchRouting: AnyObject {
    /// 詳細画面を表示
    func showDetail(item: Item)
    /// アラートを表示
    func showAlert(error: Error)
}
