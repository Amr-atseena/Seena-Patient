//
//  LoginRequestParameters.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
struct LoginRequestParameters: Codable {
    private(set) var phone: String
    private(set) var password: String
    init(phone: String, password: String) {
        self.phone = phone
        self.password = password
    }
    enum CodingKeys: String, CodingKey {
        case phone
        case password
    }
}
