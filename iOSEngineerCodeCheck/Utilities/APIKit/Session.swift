//
//  Session.swift
//  iOSEngineerCodeCheck
//
//  Created by Takehito Koshimizu on 2023/06/09.
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

// MRK: - Session
extension Session: RequestSendable {
    func send<R: Request>(_ request: R, callbackQueue: CallbackQueue?) async throws -> R.Response {
        let task = Task()
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { continuation in
                task.sessionTask = send(request, callbackQueue: callbackQueue) { result in
                    continuation.resume(with: result)
                }
            }
        } onCancel: {
            task.cancel()
        }
    }

    private final class Task: @unchecked Sendable {
        var sessionTask: SessionTask?
        func cancel() {
            sessionTask?.cancel()
        }
    }
}
