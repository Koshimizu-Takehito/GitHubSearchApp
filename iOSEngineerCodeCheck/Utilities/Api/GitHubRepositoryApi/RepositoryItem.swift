//
//  GitHubSearchEntity.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

struct RepositoryItem: Decodable {
    var items: [Item]
}
// MARK: - GitHub リポジトリデータ構造 -
struct Item: Decodable, Hashable {
    let id: ItemID
    let fullName: String
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: Owner
}

struct Owner: Decodable, Hashable {
    let avatarUrl: URL
    let htmlUrl: String
}
