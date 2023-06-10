//
//  ItemID.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/10.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

// MARK: - ItemID
struct ItemID: Hashable {
    let id: Int
}

// MARK: - Identifiable
extension ItemID: Identifiable {
}

// MARK: - RawRepresentable
extension ItemID: RawRepresentable {
    var rawValue: Int {
        id
    }

    init(rawValue: Int) {
        self.init(id: rawValue)
    }
}

// MARK: - Codable
extension ItemID: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        self.init(rawValue: value)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
