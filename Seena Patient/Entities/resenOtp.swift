//
//  resenOtp.swift
//  Seena Patient
//
//  Created by RKAnjel on 7/8/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - ResenOtp
struct ResenOtp: Codable {
    let error: ResenOtpError
    let response: ResenOtpResponse

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct ResenOtpError: Codable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct ResenOtpResponse: Codable {
    let success: String

    enum CodingKeys: String, CodingKey {
        case success = "Success"
    }
}
