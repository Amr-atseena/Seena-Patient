//
//  Status.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - Status
struct Status: Codable {
    let profilePicture, idType, financialProof, residenceProof: Bool

    enum CodingKeys: String, CodingKey {
        case profilePicture = "profile_picture"
        case idType = "id_type"
        case financialProof = "financial_proof"
        case residenceProof = "residence_proof"
    }
}
