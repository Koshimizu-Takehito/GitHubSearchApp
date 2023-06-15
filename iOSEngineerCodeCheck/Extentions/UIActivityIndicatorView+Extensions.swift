//
//  UIActivityIndicatorView+Extensions.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/16.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    func setIsAnimating(_ isAnimating: Bool) {
        if isAnimating {
            startAnimating()
        } else {
            stopAnimating()
        }
    }
}
