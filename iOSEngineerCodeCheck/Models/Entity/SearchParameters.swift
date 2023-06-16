//
//  SearchParameters.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/17.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

/// 検索パラメータ
struct SearchParameters: Hashable {
    var word = ""
    var order: StarSortingOrder?
}
