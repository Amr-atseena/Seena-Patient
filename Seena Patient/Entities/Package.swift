//
//  Package.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - Package
struct Package: Codable {
    let id: Int
    let image: String
    let name, packageDescription: String
    let price: Int
    let services: [Service]
    let phone: String?

    enum CodingKeys: String, CodingKey {
        case id, image, name
        case packageDescription = "description"
        case price, services, phone
    }
}
