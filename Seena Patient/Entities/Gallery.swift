//
//  Gallery.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - Gallery
struct Gallery: Codable {
    let id, clinicID: Int
    let image: String

    enum CodingKeys: String, CodingKey {
        case id
        case clinicID = "clinic_id"
        case image
    }
}
