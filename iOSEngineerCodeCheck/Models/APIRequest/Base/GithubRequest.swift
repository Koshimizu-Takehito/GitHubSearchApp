//
//  GithubRequest.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/09.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import APIKit

protocol GithubRequest: Request where Response: Decodable {
}

extension GithubRequest {
    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }

    var dataParser: DataParser {
        SimpleDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            fatalError()
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: data)
    }
}
