//
//  Plan.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct Plan: Codable {
    let id: Int
    let months: Int
    let percentage: Int
    let name: String
}
