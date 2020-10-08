//
//  Installment.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct Installment: Codable {
    let installmentId: Int
    let amount: Int
    let clinicName: String
    let dueDate: String
    enum CodingKeys: String, CodingKey {
        case installmentId = "id"
        case amount
        case clinicName = "name"
        case dueDate = "due_date"
    }
}
