//
//  BaseResponse.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - BaseResponse
struct BaseResponse<C: Codable>: Codable {
    let serverResonse: ServerResonse
    let response: C?
    enum CodingKeys: String, CodingKey {
        case serverResonse = "Error"
        case response = "Response"
    }
}
