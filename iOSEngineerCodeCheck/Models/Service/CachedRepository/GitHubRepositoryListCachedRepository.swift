//
//  GitHubRepositoryListCachedRepository.swift
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
    func save(items: [Item], for key: Key)
    func restore(for key: Key) -> [Item]?
}

class GitHubItemsOnMemoryRepositiry: GitHubItemsRepositiry {
    private let queue = DispatchQueue(label: #function)
    private var cache: [Key: [Item]] = [:]

    static let shared = GitHubItemsOnMemoryRepositiry()

    func save(items: [Item], for key: Key) {
        queue.sync { cache[key] = items }
    }

    func restore(for key: Key) -> [Item]? {
        queue.sync { cache[key] }
    }
}
