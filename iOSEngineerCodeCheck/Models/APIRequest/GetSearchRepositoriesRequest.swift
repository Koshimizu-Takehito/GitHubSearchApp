//
//  GetSearchRepositoriesRequest.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import APIKit

/// Githubリポジトリ検索
///
/// - [Search repositories](https://docs.github.com/ja/rest/search?apiVersion=2022-11-28#search-repositories)
struct GetSearchRepositoriesRequest {
    let word: String
    let order: StarSortingOrder?
}

extension GetSearchRepositoriesRequest: GithubRequest {
    typealias Response = RepositoryItem

    var method: HTTPMethod {
        .get
    }

    var path: String {
        "/search/repositories"
    }

    var parameters: Any? {
        var parameters = [String: Any]()
        parameters["q"] = word
        parameters["per_page"] = 50
        if let order {
            parameters["sort"] = "stars"
            parameters["order"] = order.rawValue
        }
        return parameters
    }
}
