//
//  GitHubSearchInteractor.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

actor GitHubSearchInteractor: GitHubSearchUseCase {
    @Injected var session: any RequestSendable
    @Injected var repositiry: any GitHubItemsRepositiry

    func cached(for parameters: SearchParameters) async -> [Item] {
        await repositiry.restore(for: parameters) ?? []
    }

    func fetch(with parameters: SearchParameters) async -> Result<[Item], Error> {
        let (word, order) = (parameters.word, parameters.order)
        do {
            var items: [Item] = []
            if !word.isEmpty {
                let request = GetSearchRepositoriesRequest(word: word, order: order)
                items = try await session.send(request).items
            }
            await repositiry.save(items: items, for: .init(word: word, order: order))
            return .success(items)
        } catch {
            if let items = await repositiry.restore(for: .init(word: word, order: order)) {
                return .success(items)
            } else {
                return .failure(error)
            }
        }
    }
}
