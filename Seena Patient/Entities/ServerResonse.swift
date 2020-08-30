//
//  ServerResponse.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - ServerRepsonse
struct ServerResonse: Codable {
    let status: Bool
    let code: Int
    let validation: String
    let desc: String
    let token: String
}
