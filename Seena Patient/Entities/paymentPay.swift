//
//  paymentPay.swift
//  Seena Patient
//
//  Created by RKAnjel on 6/2/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - PaymentPay
struct PaymentPay: Codable {
    let error: PaymentPayError
    let response: PaymentPayResponse

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct PaymentPayError: Codable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct PaymentPayResponse: Codable {
}
