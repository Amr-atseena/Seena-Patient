//
//  Clinic.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct Clinc: Codable {
    let id: Int
    let image: String
    let phone, name, address: String
    let gallery: [Gallery]?
    let services: [Service]?
}
