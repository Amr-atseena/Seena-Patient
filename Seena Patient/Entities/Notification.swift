//
//  Notification.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 22/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - Notification
struct Notification: Codable {
    let id: Int
    let title, message: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, message
        case createdAt = "created_at"
    }
}
