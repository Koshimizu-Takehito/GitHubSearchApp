//
//  AvatarImageLoader.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import Kingfisher
import class UIKit.UIImage

// MARK: - AvatarImageLoadable
protocol AvatarImageLoadable {
    func retrieveImage(id: ItemID) -> UIImage?
    @discardableResult func loadImage(id: ItemID, url: URL) async throws -> UIImage
}

// MARK: - AvatarImageLoader
class AvatarImageLoader: AvatarImageLoadable {
    private var cacheKeys: [ItemID: URL] = [:]
    private let queue: DispatchQueue
    private let loader: any ImageLoadable
    private let cache: any ImageCachable

    init(
        queue: DispatchQueue = .init(label: #function),
        loader: any ImageLoadable = KingfisherManager.shared,
        cache: ImageCachable = ImageCache.default
    ) {
        self.queue = queue
        self.loader = loader
        self.cache = cache
    }

    func retrieveImage(id: ItemID) -> UIImage? {
        guard let url = (queue.sync { cacheKeys[id] }) else {
            return nil
        }
        return cache.retrieveImage(forKey: url)
    }

    @discardableResult func loadImage(id: ItemID, url: URL) async throws -> UIImage {
        if let image = cache.retrieveImage(forKey: url) {
            return image
        } else {
            let image = try await loader.loadImage(url: url)
            queue.sync { cacheKeys[id] = url }
            return image
        }
    }
}
