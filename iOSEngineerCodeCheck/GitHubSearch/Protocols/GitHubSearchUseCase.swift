//
//  GitHubSearchUseCase.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

// MARK: - Usecase
/// Usecase
protocol GitHubSearchUseCase: AnyObject {
    func cached(for parameters: SearchParameters) async -> [Item]
    func fetch(with parameters: SearchParameters) async -> Result<[Item], Error>
}
