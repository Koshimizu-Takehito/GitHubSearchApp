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
    func loadImage(with url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> any Cancelable
    func loadImage(with url: URL) async throws -> UIImage
}
