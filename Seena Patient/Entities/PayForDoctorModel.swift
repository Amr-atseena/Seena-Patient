//
//  PayForDoctorModel.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/30/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - PayForDoctorModel
struct PayForDoctorModel: Codable {
    let error: PayForDoctorModelError
    let response: PayForDoctorModelResponse

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct PayForDoctorModelError: Codable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct PayForDoctorModelResponse: Codable {
    let success: String

    enum CodingKeys: String, CodingKey {
        case success = "Success"
    }
}
