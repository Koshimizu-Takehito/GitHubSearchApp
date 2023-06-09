//
//  GitHubSearchInteractor.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import APIKit

actor GitHubSearchInteractor: GitHubSearchInputUsecase {
    func fetch(word: String, order: StarSortingOrder?) async -> GitHubSearchFetchResult {
        do {
            let request = GetSearchRepositoriesRequest(word: word, order: order)
            let items = try await Session.shared.send(request).items
            if items.isEmpty {
                return .empty
            } else {
                return .items(items)
            }
        } catch {
            return .error(error)
        }
    }
}
