//
//  GitHubDetailUseCase.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/18.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

// MARK: - Usecase
/// Usecase
protocol GitHubDetailUseCase: AnyObject {
    /// 一意識別子をもとにキャッシュ済みのGitHubリポジトリのエンティティを取得する
    ///
    /// - Parameter id: GitHubリポジトリの一意識別子
    /// - Returns: GitHubリポジトリのエンティティ
    func cached(for id: ItemID) async -> Item?
}
