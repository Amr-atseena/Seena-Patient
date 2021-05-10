//
//  ResetPassword.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/9/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

struct ResetPassword: Decodable {
    let error: ResetPasswordError
    let response: ResetPasswordResponse

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct ResetPasswordError: Decodable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct ResetPasswordResponse: Codable {
    let restPassword: String

    enum CodingKeys: String, CodingKey {
        case restPassword = "RestPassword"
    }
}
