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
    let session = Session.shared
    let repositiry = GitHubItemsOnMemoryRepositiry.shared

    nonisolated func restore(word: String, order: StarSortingOrder?) -> [Item] {
        repositiry.restore(for: .init(word: word, order: order)) ?? []
    }

    func fetch(word: String, order: StarSortingOrder?) async -> Result<[Item], Error> {
        do {
            var items: [Item] = []
            if !word.isEmpty {
                let request = GetSearchRepositoriesRequest(word: word, order: order)
                items = try await session.send(request).items
            }
            repositiry.save(items: items, for: .init(word: word, order: order))
            return .success(items)
        } catch {
            if let items = repositiry.restore(for: .init(word: word, order: order)) {
                return .success(items)
            } else {
                return .failure(error)
            }
        }
    }
}
