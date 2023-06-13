//
//  GitHubSearchViewRowItem.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/06/04.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import class UIKit.UIImage

struct GitHubSearchViewRowItem: Hashable, Identifiable {
    let id: ItemID
    let fullName: String
    let language: String?
    let stars: String
    let avatarImage: UIImage?
}

extension GitHubSearchViewRowItem {
    init(item: Item, image: UIImage?) {
        self.init(
            id: item.id,
            fullName: item.fullName,
            language: "言語 \(item.language ?? "")",
            stars: "☆ \(item.stargazersCount.decimal())",
            avatarImage: image
        )
    }
}

extension Array where Element == GitHubSearchViewRowItem {
    init(items: [Item], imageLoader loder: ImageManaging) {
        self = items.map { item in
            .init(
                item: item,
                image: loder.cacheImage(forKey: item.owner.avatarUrl)
            )
        }
    }
}
