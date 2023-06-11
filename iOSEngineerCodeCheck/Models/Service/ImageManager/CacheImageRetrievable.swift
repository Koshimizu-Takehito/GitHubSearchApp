//
//  CacheImageRetrievable.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import class UIKit.UIImage

protocol CacheImageRetrievable {
    func cacheImage(forKey url: URL) -> UIImage?
}
