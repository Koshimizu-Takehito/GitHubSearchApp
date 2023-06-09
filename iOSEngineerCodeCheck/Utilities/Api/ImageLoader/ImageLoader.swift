//
//  ImageLoader.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/21.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import class UIKit.UIImage

// MARK: - ImageLoadable
protocol ImageLoadable {
    func load(url: URL) async throws -> UIImage
}

// MARK: - ImageLoader
final class ImageLoader: ImageLoadable {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    /// GitHub APIから画像データの取得
    func load(url: URL) async throws -> UIImage {
        let (data, _) = try await session.data(for: URLRequest(url: url))
        switch UIImage(data: data) {
        case let image?:
            return image
        case _:
            throw ApiError.invalidData
        }
    }
}
