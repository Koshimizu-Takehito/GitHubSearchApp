//
//  GitHubSearchView.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

// View
protocol GitHubSearchView: AnyObject {
    func startLoading()
    func reloadTableView()
    func resetDisplay()
    func showErrorAlert(error: Error)
    func showEmptyMessage()
    func configure(order: StarSortingOrder?)
    func configure(item: GitHubSearchViewItem, at index: Int)
}
