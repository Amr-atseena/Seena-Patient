//
//  TestPDF.swift
//  Seena Patient
//
//  Created by RKAnjel on 6/21/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - TestPDF
struct TestPDF: Codable {
    let error: TestPDFError
    let response: TestPDFResponse

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct TestPDFError: Codable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct TestPDFResponse: Codable {
    let user: User
    let status: TestPDFStatus
}

// MARK: - Status
struct TestPDFStatus: Codable {
    let profilePicture, idType, financialProof, residenceProof: Bool

    enum CodingKeys: String, CodingKey {
        case profilePicture = "profile_picture"
        case idType = "id_type"
        case financialProof = "financial_proof"
        case residenceProof = "residence_proof"
    }
}
