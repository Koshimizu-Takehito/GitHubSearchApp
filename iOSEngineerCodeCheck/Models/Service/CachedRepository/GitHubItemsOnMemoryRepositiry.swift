//
//  GitHubItemsOnMemoryRepositiry.swift
//  iOSEngineerCodeCheck
//
//  Created by akio0911 on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

/// 「GitHubリポジトリ」のリストを提供するRepositiry
protocol GitHubItemsRepositiry {
    /// 検索パラメータをキーとして保存
    func save(items: [Item], for key: SearchParameters) async
    /// 検索パラメータをキーとして復元
    func restore(for key: SearchParameters) async -> [Item]?
}

/// 「GitHubリポジトリ」を提供するRepositiry
protocol GitHubItemRepositiry {
    /// 識別子をキーとして保存
    func save(item: Item, for key: ItemID) async
    /// 識別子をキーとして復元
    func restore(for key: ItemID) async -> Item?
}

/// 「GitHubリポジトリ」をメモリ上にキャッシュする実装を提供する
actor GitHubItemsOnMemoryRepositiry {
    /// 検索パラメータをキーとしたキャッシュ
    private var responseCache: [SearchParameters: [Item]] = [:]
    static let shared = GitHubItemsOnMemoryRepositiry()

    private init() {}
}

extension GitHubItemsOnMemoryRepositiry: GitHubItemsRepositiry {
    func save(items: [Item], for key: SearchParameters) async {
        responseCache[key] = items
    }

    func restore(for key: SearchParameters) async -> [Item]? {
        responseCache[key]
    }
}
