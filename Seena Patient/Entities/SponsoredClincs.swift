//
//  SponsoredClincs.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/23/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - SponsoredClincs
struct SponsoredClincs: Decodable {
    let error: SponsoredClincsError
    let response: [SponsoredClincsResponse]

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct SponsoredClincsError: Decodable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct SponsoredClincsResponse: Decodable {
    let id: Int
    let image: String
    let phone, name, address: String
}
