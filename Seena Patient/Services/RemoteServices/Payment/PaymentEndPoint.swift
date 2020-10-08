//
//  PaymentEndPoint.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 28/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import Moya
enum PaymentEndPoint {
    case paymentHome(String)
    case transactions(String)
}
// MARK: - TargetType Protocol Implementation
extension PaymentEndPoint: TargetType, EnvironmentProtocol {
    var baseURL: URL {
        return apiBaseURL
    }
    var path: String {
        switch self {
        case .paymentHome:
            return "payment/home"
        case .transactions:
            return "payment/transactions"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .paymentHome:
            return .requestPlain
        case .transactions:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        switch self {
        case .paymentHome(let token):
        return [
            "Authorization": "Bearer \(token)",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": "en"
        ]
        case .transactions(let token):
        return [
            "Authorization": "Bearer \(token)",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": "en"
        ]
        }
    }
}
