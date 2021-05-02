//
//  Transaction.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 10/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - Transaction
struct Transaction: Codable {
    let id: Int
    let name: String
    let status: TransactionStatus
    let dueDate: String
    let amount, userID: Int
    enum CodingKeys: String, CodingKey {
        case id, name, status
        case dueDate = "due_date"
        case amount
        case userID = "user_id"
    }
}
enum TransactionStatus: String, Codable {
    case paid = "paid"
    case purchased = "purchased"
    case rejected = "rejected"
    var localization: String {
        return self.rawValue.localized
    }
}
