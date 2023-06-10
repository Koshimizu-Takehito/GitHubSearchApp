//
//  ImageCachable.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import class UIKit.UIImage

// MARK: - ImageCachable
protocol ImageCachable {
    func retrieveImage(forKey url: URL) -> UIImage?
}
