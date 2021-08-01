//
//  PaymentEndPoint.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 28/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import Moya
import MOLH
enum PaymentEndPoint {
    case paymentHome(String, String)
    case transactions(String)
    case pay(String, Payment)
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
        case .pay:
            return "payment/pay"
        }
    }
    var method: Moya.Method {
        switch self {
        case .pay:
            return .patch
        case .paymentHome:
            return .post
        default:
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .paymentHome(_, let status):
            let params = ["status": status] as [String: Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .transactions:
            return .requestPlain
        case .pay(_, let payment):
            let params = ["installment_id": payment.installment.installmentId,
                          "payment_method": payment.paymentMethod,
                          "transaction_id": payment.tansactionId,
                          "id": payment.account.id
            ] as [String: Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
        case .paymentHome(let token, _):
        return [
            "Authorization": "Bearer \(token)",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": MOLHLanguage.currentAppleLanguage()
        ]
        case .transactions(let token):
        return [
            "Authorization": "Bearer \(token)",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": MOLHLanguage.currentAppleLanguage()
        ]
        case .pay(let token, _):
            return [
                "Authorization": "Bearer \(token)",
                "Accept-Encoding": "gzip, deflate, br",
                "Accept-Language": MOLHLanguage.currentAppleLanguage()
            ]
        }
    }
}

