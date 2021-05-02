//
//  NotificationEndPoint.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 22/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import Moya
import MOLH
enum NotificationEndPoint {
    case notifications(NotificationRequestParameters)
}
// MARK: - TargetType Protocol Implementation
extension NotificationEndPoint: TargetType, EnvironmentProtocol {
    var baseURL: URL {
        return apiBaseURL
    }
    var path: String {
        switch self {
        case .notifications:
            return "notifications"
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
        case .notifications(let params):
            let paramsDic = ["offset": params.offset, "limit": params.limit]
            return .requestParameters(parameters: paramsDic, encoding: URLEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
        case .notifications(let params):
        return [
            "Authorization": "Bearer \(params.token)",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": MOLHLanguage.currentAppleLanguage()
        ]
        }
    }
}
