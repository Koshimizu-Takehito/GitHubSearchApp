//
//  GitHubSearchViewItem+StarSortingOrder.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/16.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import class UIKit.UIImage
import class UIKit.UIColor

extension GitHubSearchViewItem {
    struct StarSortingOrder {
        var title: String
        var image: UIImage
    }
}

extension GitHubSearchViewItem.StarSortingOrder {
    init(_ order: StarSortingOrder?) {
        self.init(title: order.title, image: .image(color: order.color))
    }

    static var none: Self {
        self.init(.none)
    }
}

private extension Optional<StarSortingOrder> {
    var title: String {
        switch self {
        case .none:
            return "☆ Star数 "
        case .asc:
            return "☆ Star数 ⍒"
        case .desc:
            return "☆ Star数 ⍋"
        }
    }

    var color: UIColor {
        UIColor(named: "\(Wrapped.self).\(self?.rawValue ?? "none")")!
    }
}
