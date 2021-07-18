//
//  GetUserStatus.swift
//  Seena Patient
//
//  Created by RKAnjel on 6/21/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - GetUserStatus
struct GetUserStatus: Codable {
    let error: GetUserStatusError
    let response: GetUserStatusResponse

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct GetUserStatusError: Codable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct GetUserStatusResponse: Codable {
    let isEnabled, message, messageAr: String

    enum CodingKeys: String, CodingKey {
        case isEnabled = "IsEnabled"
        case message = "Message"
        case messageAr = "MessageAr"
    }
}
