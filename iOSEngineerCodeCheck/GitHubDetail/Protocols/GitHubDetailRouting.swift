//
//  GitHubDetailRouting.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

// MARK: - Router
/// Router
@MainActor
protocol GitHubDetailRouting: AnyObject {
    /// GitHubリポジトリのWebページを表示する
    func showGitHubPage(url: URL)
}
