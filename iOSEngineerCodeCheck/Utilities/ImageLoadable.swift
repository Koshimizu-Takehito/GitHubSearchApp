//
//  ImageLoadable.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import class UIKit.UIImage

// MARK: - ImageLoadable
protocol ImageLoadable {
    @discardableResult
    func retrieveImage(with url: URL, completionHandler: @escaping ((Result<UIImage, Error>) -> Void)) -> any Cancelable
    func loadImage(url: URL) async throws -> UIImage
}
