//
//  GitHubSearchPresentation.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

// Presenter
protocol GitHubSearchPresentation: AnyObject {
    /// サーチボタンのタップ通知
    func didTapSearchButton(word: String)
    /// 検索テキストの削除を通知
    func didClearSearchText()
    /// セルタップを通知
    func didSelectRow(at index: Int)
    /// お気に入り順のボタンタップを通知
    func didTapStarOderButton()
    /// セルの表示直前であることを通知
    func willDisplayRow(at index: Int)

    var numberOfRow: Int { get }
    func item(at index: Int) -> GitHubSearchViewItem
}
