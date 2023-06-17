//
//  GitHubDetailView.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

// View
@MainActor
protocol GitHubDetailView: AnyObject {
    /// 詳細表示データを設定する
    func configure(item: GitHubDetailViewItem)
}
