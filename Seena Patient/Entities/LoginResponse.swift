//
//  LoginResponse.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - LoginResponse
struct LoginResponse: Codable {
    let user: User?
    let status: Status?
}
