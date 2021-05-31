//
//  InstallmentPlansModel.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/30/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - InstallmentPlansModel
struct InstallmentPlansModel: Codable {
    let error: InstallmentPlansModelError
    let response: [InstallmentPlansModelResponse]

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct InstallmentPlansModelError: Codable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct InstallmentPlansModelResponse: Codable {
    let id: Int
    let arName, enName: String
    let months, percentage: Int
//    let createdAt, updatedAt: JSONNull?
    let value: Int

    enum CodingKeys: String, CodingKey {
        case id
        case arName = "ar_name"
        case enName = "en_name"
        case months, percentage
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
        case value
    }
}
