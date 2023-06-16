//
//  ImageCache.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import Kingfisher

extension ImageCache: ImageCachable {
    func cacheImage(forKey url: URL) -> UIImage? {
        retrieveImageInMemoryCache(forKey: url.cacheKey)
    }
}
