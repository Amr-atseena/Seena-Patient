//
//  Speciality.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - Speciality
struct Speciality: Codable {
    let id: Int
    let image: String?
    let speciality: String
    let services: [Service]?
    let clinics: [Clinic]?
}
