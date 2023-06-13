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
    func configure(order: StarSortingOrder?)
    func configure(item: GitHubSearchViewItem)
    func configure(row: GitHubSearchViewRowItem, at index: Int)
    func showErrorAlert(error: Error)
}
