//
//  GitHubSearchInteractor.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/04/25.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import APIKit

final class GitHubSearchInteractor {
    private var currentTask: Task<Void, Never>?
    weak var presenter: GitHubSearchOutputUsecase?
}

extension GitHubSearchInteractor: GitHubSearchInputUsecase {
    func fetch(word: String, orderType: StarSortingOrder?) {
        cancel()
        currentTask = Task {
            let result: Result<RepositoryItem, Error>
            do {
                let request = GetSearchRepositoriesRequest(word: word, order: orderType)
                let response = try await Session.shared.send(request)
                result = .success(response)
            } catch {
                result = .failure(error)
            }
            presenter?.didFetchResult(result: result)
        }
    }

    func cancel() {
        currentTask?.cancel()
    }
}
