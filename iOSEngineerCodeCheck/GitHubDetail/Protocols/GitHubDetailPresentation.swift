//
//  GitHubDetailPresentation.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

// Presentation
protocol GitHubDetailPresentation: AnyObject {
    func viewDidLoad() async
    func safariButtoDidPush() async
}

extension GitHubDetailPresentation {
    func viewDidLoad() {
        Task { [weak self] in
            await self?.viewDidLoad()
        }
    }

    func safariButtoDidPush() {
        Task { [weak self] in
            await self?.safariButtoDidPush()
        }
    }
}
