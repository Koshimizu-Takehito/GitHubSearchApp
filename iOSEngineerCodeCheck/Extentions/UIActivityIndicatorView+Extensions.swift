//
//  UIActivityIndicatorView+Extensions.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/16.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

enum ActivityIndicatorState {
    case started
    case stopped
}

extension UIActivityIndicatorView {
    var state: ActivityIndicatorState {
        get {
            isAnimating ? .started : .stopped
        }
        set {
            switch newValue {
            case .started:
                startAnimating()
            case .stopped:
                stopAnimating()
            }
        }
    }
}
