//
//  GitHubSearchViewItem.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/14.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

struct GitHubSearchViewItem {
    var indicator: ActivityIndicator
    var emptyDescription: EmptyDescription
    var table: Table
}

extension GitHubSearchViewItem {
    struct ActivityIndicator {
        var state: ActivityIndicatorState
    }

    struct EmptyDescription {
        var isHidden: Bool
    }

    struct Table {
        var items: [TableRow]?
    }
}

extension GitHubSearchViewItem {
    /// 初期状態を表現した ViewItem
    static var initial: Self {
        .init(
            indicator: .init(state: .stopped),
            emptyDescription: .init(isHidden: true),
            table: .empty
        )
    }

    /// エンプティステイトを表現した ViewItem
    static var empty: Self {
        .init(
            indicator: .init(state: .stopped),
            emptyDescription: .init(isHidden: false),
            table: .empty
        )
    }

    /// ローディング状態を表現した ViewItem
    static var loading: Self {
        .init(
            indicator: .init(state: .started),
            emptyDescription: .init(isHidden: true),
            table: .empty
        )
    }

    /// 検索結果のリストを表現した ViewItem
    static func list(items entities: [Item], cachable: ImageCachable) -> Self {
        var item = GitHubSearchViewItem.initial
        item.table.items = .init(items: entities, cachable: cachable)
        return item
    }
}

extension GitHubSearchViewItem.Table {
    /// エンプティステイト
    static var empty: Self {
        .init(items: [])
    }
}
