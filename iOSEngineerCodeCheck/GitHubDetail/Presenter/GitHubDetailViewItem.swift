//
//  GitHubDetailViewItem.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/06/08.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import class UIKit.UIImage

struct GitHubDetailViewItem {
    let fullName: String
    let language: String
    let stars: String
    let watchers: String
    let forks: String
    let issues: String
    let avatarImage: UIImage?
}

extension GitHubDetailViewItem {
    init(item: Item, avatarImage: UIImage?) {
        self.init(
            fullName: item.fullName,
            language: "言語 \(item.language ?? "")",
            stars: "\(item.stargazersCount.decimal())",
            watchers: "\(item.watchersCount.decimal())",
            forks: "\(item.forksCount.decimal())",
            issues: "\(item.openIssuesCount.decimal())",
            avatarImage: avatarImage
        )
    }
}
