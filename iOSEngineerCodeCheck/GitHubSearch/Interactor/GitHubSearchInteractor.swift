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
        do {
            var items: [Item] = []
            if !parameters.word.isEmpty {
                let request = GetSearchRepositoriesRequest(parameters)
                items = try await session.send(request).items
            }
            await repositiry.save(items: items, for: parameters)
            return .success(items)
        } catch {
            if let items = await repositiry.restore(for: parameters) {
                return .success(items)
            } else {
                return .failure(error)
            }
        }
    }
}
