//
//  GitHubSearchViewItem+TableRow.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/14.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import class UIKit.UIImage

extension GitHubSearchViewItem {
    struct TableRow: Hashable, Identifiable {
        let id: ItemID
        let fullName: String
        let language: String?
        let stars: String
        let avatarImage: UIImage?
    }
}

extension GitHubSearchViewItem.TableRow {
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

extension Array where Element == GitHubSearchViewItem.TableRow {
    init(items: [Item], cachable: ImageCachable) {
        self = items.map { item in
            .init(item: item, image: cachable.cachedImage(forKey: item.owner.avatarUrl))
        }
    }
}
