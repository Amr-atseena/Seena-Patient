//
//  OTPtransferCompleteModel.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/30/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation


// MARK: - OTPtransferCompleteModel
struct OTPtransferCompleteModel: Codable {
    let error: OTPtransferCompleteModelError
    let response: OTPtransferCompleteModelResponse

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct OTPtransferCompleteModelError: Codable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct OTPtransferCompleteModelResponse: Codable {
    let doctor: Doctor
    let createdAt, otp: String

    enum CodingKeys: String, CodingKey {
        case doctor, createdAt
        case otp = "OTP"
    }
}

// MARK: - Doctor
struct Doctor: Codable {
    let name: String
    let image: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case image
    }
}
