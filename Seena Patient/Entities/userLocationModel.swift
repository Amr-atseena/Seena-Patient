//
//  userLocationModel.swift
//  Seena Patient
//
//  Created by RKAnjel on 7/14/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - UserLocationModel
struct UserLocationModel: Codable {
    let error: UserLocationModelError
    let response: UserLocationModelResponse

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct UserLocationModelError: Codable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct UserLocationModelResponse: Codable {
    let location: String

    enum CodingKeys: String, CodingKey {
        case location = "Location"
    }
}
