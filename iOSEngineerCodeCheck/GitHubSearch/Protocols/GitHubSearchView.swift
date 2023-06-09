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
    func configure()
    func startLoading()
    func stopLoading()
    func reloadTableView()
    func resetDisplay()
    func appearErrorAlert(message: String)
    func appearNotFound(message: String)
    func configure(order: Order)
    func configure(item: GitHubSearchViewItem, at index: Int)
}
