//
//  SignUpRequestParamaters.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
struct SignUpRequestParamaters: Codable {
    let phone: String
    let firstName: String
    let lastName: String
    let password: String
    let confirmPassword: String
    let birthdate: String
    let idType: Int
    let financialProof: Int
    let residenceProof: Int
    enum CodingKeys: String, CodingKey {
        case phone, password, confirmPassword
        case firstName = "first_name"
        case lastName = "last_name"
        case birthdate = "birth_date"
        case idType = "id_type"
        case financialProof = "financial_proof"
        case residenceProof = "residence_proof"
    }
}
