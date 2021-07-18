//
//  resendPaymentOtp.swift
//  Seena Patient
//
//  Created by RKAnjel on 7/8/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - ResendPaymentOtp
struct ResendPaymentOtp: Codable {
    let error: ResendPaymentOtpError
    let response: ResendPaymentOtpResponse

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct ResendPaymentOtpError: Codable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct ResendPaymentOtpResponse: Codable {
    let success: String

    enum CodingKeys: String, CodingKey {
        case success = "Success"
    }
}
