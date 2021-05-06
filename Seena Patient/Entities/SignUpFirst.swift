//
//  SignUpFirst.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/5/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

//struct SignUpFirst: Decodable{
//    var phone: String?
//    var firstName: String?
//    var lastName: String?
//    var password: String?
//    var confirmPassword: String?
//    var birthdate: String?
//    var idType: Int
//    var financialProof: Int
//    var residenceProof: Int
//    var email: String?
//    enum CodingKeys: String, CodingKey {
//        case phone, password, confirmPassword, email
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case birthdate = "birth_date"
//        case idType = "id_type"
//        case financialProof = "financial_proof"
//        case residenceProof = "residence_proof"
//    }
//}



struct SignUpFirst: Decodable {
    var error: SignUpFirstError?
    var response: SignUpFirstResponse?

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct SignUpFirstError: Decodable {
    var status: Bool?
    var code: Int?
    var validation, desc, token: String?
}

// MARK: - Response
struct SignUpFirstResponse: Decodable {
    var user: SignUpFirstUser?
    var status: SignUpFirstStatus?
}

// MARK: - Status
struct SignUpFirstStatus: Decodable {
    var profilePicture, idType, financialProof, residenceProof: Bool?

    enum CodingKeys: String, CodingKey {
        case profilePicture = "profile_picture"
        case idType = "id_type"
        case financialProof = "financial_proof"
        case residenceProof = "residence_proof"
    }
}

// MARK: - User
struct SignUpFirstUser: Decodable {
    var id: Int?
    var firstName, lastName: String?
    var image: String?
    var email, phone, birthDate, role: String?
//    var emailVerifiedAt, socialID, pin: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case image, email, phone
        case birthDate = "birth_date"
        case role
//        case emailVerifiedAt = "email_verified_at"
//        case socialID = "social_id"
//        case pin
    }
}
