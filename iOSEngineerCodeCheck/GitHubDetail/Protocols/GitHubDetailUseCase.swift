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
    func cached(for id: ItemID) async -> Item?
}
