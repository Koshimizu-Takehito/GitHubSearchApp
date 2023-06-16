//
//  UIButton+Extenisons.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/16.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIButton {
    func setBackgroundImage(_ image: UIImage?) {
        setBackgroundImage(image, for: .normal)
        setBackgroundImage(image, for: .highlighted)
        setBackgroundImage(image, for: .selected)
        setBackgroundImage(image, for: [.selected, .highlighted])
    }
}
