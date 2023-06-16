//
//  GitHubSearchUsecase.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

// MARK: - Usecase
/// Usecase
protocol GitHubSearchInputUsecase: AnyObject {
    func cached(word: String, order: StarSortingOrder?) async -> [Item]
    func fetch(word: String, order: StarSortingOrder?) async -> Result<[Item], Error>
}
