//
//  UINavigationBar+Extensions.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/18.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UINavigationBar {
    static func setUp() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = Asset.Colors.tint.color
    }
}
