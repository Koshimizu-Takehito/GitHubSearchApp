//
//  GitHubSearchView.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

// MARK: - View
@MainActor
protocol GitHubSearchView: AnyObject {
    func configure(item: GitHubSearchViewItem)
    func configure(row: GitHubSearchViewItem.TableRow, at index: Int)
    func configure(order: GitHubSearchViewItem.StarSortingOrder)
    func showErrorAlert(error: Error)
}
