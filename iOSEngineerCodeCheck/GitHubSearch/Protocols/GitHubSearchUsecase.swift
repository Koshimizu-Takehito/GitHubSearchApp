//
//  GitHubSearchUsecase.swift
//  iOSEngineerCodeCheck
//
//  Created by 日高隼人 on 2023/05/19.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

// Interactor インプット
protocol GitHubSearchInputUsecase: AnyObject {
    func fetch(word: String, order: StarSortingOrder?) async -> Result<[Item], Error>
    func restore(word: String, order: StarSortingOrder?) -> [Item]
}
