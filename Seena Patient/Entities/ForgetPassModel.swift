//
//  ForgetPassModel.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/5/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

struct ForgetPassModel : Decodable{
    let error: ForgetPassModelError
        let response: ForgetPassModelResponse

        enum CodingKeys: String, CodingKey {
            case error = "Error"
            case response = "Response"
        }
    }

    // MARK: - Error
    struct ForgetPassModelError: Decodable {
        let status: Bool
        let code: Int
        let validation, desc, token: String
    }

    // MARK: - Response
    struct ForgetPassModelResponse: Decodable {
        let otp: String

        enum CodingKeys: String, CodingKey {
            case otp = "OTP"
        }
}
