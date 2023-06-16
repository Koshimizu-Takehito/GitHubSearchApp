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
    typealias ViewItem = GitHubSearchViewItem
    typealias TableRow = GitHubSearchViewItem.TableRow
    typealias Order = GitHubSearchViewItem.StarSortingOrder

    func configure(item: ViewItem)
    func configure(item: ViewItem, order: Order)
    func configure(row: TableRow, at index: Int)
    func showErrorAlert(error: Error)
}
