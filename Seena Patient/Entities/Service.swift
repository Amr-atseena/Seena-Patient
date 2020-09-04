//
//  Service.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - Service
struct Service: Codable {
    let seriveId: Int
    let image: String
    let name: String
    let specialityID: Int?
    let serviceDescription: String?
    let priceMin, priceMax: Int?
    let clinics: [Clinic]?

    enum CodingKeys: String, CodingKey {
        case seriveId = "id"
        case image, name
        case specialityID = "speciality_id"
        case serviceDescription = "description"
        case priceMin = "price_min"
        case priceMax = "price_max"
        case clinics
    }
}
