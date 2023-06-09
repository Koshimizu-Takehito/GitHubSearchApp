//
//  SimpleDataParser.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import APIKit

struct SimpleDataParser: DataParser {
    var contentType: String?
    func parse(data: Data) throws -> Any { data }
}
