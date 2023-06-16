//
//  Cancelable.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/11.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol Cancelable {
    func cancel()
}

extension Optional: Cancelable where Wrapped: Cancelable {
    func cancel() {
        self?.cancel()
    }
}

extension URLSessionTask: Cancelable {
}

extension Task: Cancelable {
}
