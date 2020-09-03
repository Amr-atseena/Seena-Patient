//
//  SplashEndPoint.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import Moya
enum SplashEndPoint {
    case splash
}
// MARK: - TargetType Protocol Implementation
extension SplashEndPoint: TargetType, EnvironmentProtocol {
    var baseURL: URL {
        return apiBaseURL
    }
    var path: String {
        switch self {
        case .splash:
            return "splash"
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
        case .splash:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        return [
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": "en"
        ]
    }
}
