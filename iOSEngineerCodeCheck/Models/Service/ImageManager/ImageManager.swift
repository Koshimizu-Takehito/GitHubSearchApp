//
//  ImageManager.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import Kingfisher
import class UIKit.UIImage

protocol ImageManaging: ImageLoadable, ImageCachable {
}

final class ImageManager: ImageManaging {
    let loadable: any ImageLoadable
    let cachable: any ImageCachable

    init(loadable: any ImageLoadable = KingfisherManager.shared, cachable: any ImageCachable = ImageCache.default) {
        self.loadable = loadable
        self.cachable = cachable
    }

    func cacheImage(forKey url: URL) -> UIImage? {
        cachable.cacheImage(forKey: url)
    }

    @discardableResult
    func loadImage(with url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> any Cancelable {
        loadable.loadImage(with: url, completion: completion)
    }

    func loadImage(with url: URL) async throws -> UIImage {
        try await loadable.loadImage(with: url)
    }
}
