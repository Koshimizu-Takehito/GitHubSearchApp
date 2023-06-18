//
//  GitHubDetailInteractor.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/18.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

actor GitHubDetailInteractor: GitHubDetailUseCase {
    @Injected var repositiry: any GitHubItemRepositiry

    func cached(for id: ItemID) async -> Item? {
        await repositiry.restore(for: id)
    }
}
