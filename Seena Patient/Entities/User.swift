//
//  User.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - User
struct User: Codable {
    let userId: Int
    let firstName, lastName: String
    let image: String
    let phone, birthDate, role: String
    let status : String?

    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case image, phone
        case birthDate = "birth_date"
        case role
        case status

    }
}
