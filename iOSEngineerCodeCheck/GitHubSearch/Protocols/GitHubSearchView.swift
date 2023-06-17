//
//  GitHubSearchView.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

// MARK: - View
/// View
@MainActor
protocol GitHubSearchView: AnyObject {
    typealias ViewItem = GitHubSearchViewItem
    typealias TableRow = GitHubSearchViewItem.TableRow
    typealias Order = GitHubSearchViewItem.StarSortingOrder

    func configure(order: Order)
    func configure(item: ViewItem)
    func configure(row: TableRow, at index: Int)
}

extension GitHubSearchView {
    func configure(item: ViewItem, order: Order) {
        configure(item: item)
        configure(order: order)
    }
}
