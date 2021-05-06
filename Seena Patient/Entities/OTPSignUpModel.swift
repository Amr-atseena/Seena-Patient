//
//  OTPSignUpModel.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/5/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

struct OTPSignUpModel: Decodable {
    var error: OTPSignUpModelError?
    var response: OTPSignUpModelResponse?

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct OTPSignUpModelError: Decodable {
    var status: Bool?
    var code: Int?
    var validation, desc, token: String?
}

// MARK: - Response
struct OTPSignUpModelResponse: Decodable {
    var otp: String?

    enum CodingKeys: String, CodingKey {
        case otp = "OTP"
    }
}
