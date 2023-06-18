//
//  ImageManager.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import class UIKit.UIImage

protocol ImageManaging: ImageLoadable, ImageCachable {
}

final class ImageManager: ImageManaging {
    @Injected var loadable: any ImageLoadable
    @Injected var cachable: any ImageCachable

    func cachedImage(forKey url: URL) -> UIImage? {
        cachable.cachedImage(forKey: url)
    }

    @discardableResult
    func loadImage(with url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> any Cancelable {
        loadable.loadImage(with: url, completion: completion)
    }

    func loadImage(with url: URL) async throws -> UIImage {
        try await loadable.loadImage(with: url)
    }
}
