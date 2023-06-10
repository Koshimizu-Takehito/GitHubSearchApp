//
//  KingfisherManager.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import Kingfisher

extension KingfisherManager: ImageLoadable {
    @discardableResult
    func retrieveImage(with url: URL, completionHandler: @escaping ((Result<UIImage, Error>) -> Void)) -> any Cancelable {
        retrieveImage(with: url) { result in
            let result = result
                .map(\.image)
                .mapError { $0 as Error }
            completionHandler(result)
        }
    }

    func loadImage(url: URL) async throws -> UIImage {
        let cancelable = AnonymousCancelable()
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                cancelable.wrapped = retrieveImage(with: url) { result in
                    let result = result
                        .map(\.image)
                        .mapError { $0 as Error }
                    continuation.resume(with: result)
                }
            }
        } onCancel: {
            cancelable.cancel()
        }
    }
}

private final class AnonymousCancelable: @unchecked Sendable, Cancelable {
    var wrapped: (any Cancelable)?

    init(cancelable: some Cancelable) {
        self.wrapped = cancelable
    }

    init() {
        self.wrapped = nil
    }

    func cancel() {
        wrapped?.cancel()
    }
}

extension Kingfisher.DownloadTask: Cancelable {
}
