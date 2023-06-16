//
//  GitHubItemsOnMemoryRepositiry.swift
//  iOSEngineerCodeCheck
//
//  Created by akio0911 on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GitHubItemsRepositiryKey: Hashable {
    let word: String
    let order: StarSortingOrder?
}

protocol GitHubItemsRepositiry {
    typealias Key = GitHubItemsRepositiryKey
    func save(items: [Item], for key: Key) async
    func restore(for key: Key) async -> [Item]?
}

actor GitHubItemsOnMemoryRepositiry: GitHubItemsRepositiry {
    private var cache: [Key: [Item]] = [:]
    static let shared = GitHubItemsOnMemoryRepositiry()

    private init() {}

    func save(items: [Item], for key: Key) async {
        cache[key] = items
    }

    func restore(for key: Key) async -> [Item]? {
        cache[key]
    }
}
