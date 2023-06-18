//
//  RequestSendable.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/18.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import APIKit

// MRK: - RequestSendable
/// リクエストを送信することができる機能を提供するプロトコル
protocol RequestSendable {
    /// リクエストを送信する
    func send<R: Request>(_ request: R, callbackQueue: CallbackQueue?) async throws -> R.Response
}

extension RequestSendable {
    /// リクエストを送信する
    func send<R: Request>(_ request: R) async throws -> R.Response {
        try await send(request, callbackQueue: nil)
    }
}
