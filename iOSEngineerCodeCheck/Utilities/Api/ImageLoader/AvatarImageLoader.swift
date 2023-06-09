//
//  AvatarImageLoader.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import class UIKit.UIImage

// MARK: - AvatarImageLoadable
protocol AvatarImageLoadable {
    func image(id: Int) -> UIImage?
    @discardableResult func load(item: Item) async throws -> UIImage
}

// MARK: - AvatarImageLoader
class AvatarImageLoader: AvatarImageLoadable {
    private var images: [Int: UIImage] = [:]
    private let queue: DispatchQueue
    private let loader: any ImageLoadable

    init(
        queue: DispatchQueue = .init(label: #function),
        loader: any ImageLoadable = ImageLoader()
    ) {
        self.queue = queue
        self.loader = loader
    }

    func image(id: Int) -> UIImage? {
        queue.sync { images[id] }
    }

    @discardableResult func load(item: Item) async throws -> UIImage {
        if let image = (queue.sync { images[item.id] }) {
            return image
        } else {
            let image = try await loader.load(url: item.owner.avatarUrl)
            queue.sync { images[item.id] = image }
            return image
        }
    }
}
