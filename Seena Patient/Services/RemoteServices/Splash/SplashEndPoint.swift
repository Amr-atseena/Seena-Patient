//
//  SplashEndPoint.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import Moya
import MOLH
enum SplashEndPoint {
    case splash
    case fcmToken(String, String, String)
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
        case .fcmToken:
            return "set-token"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fcmToken:
            return .post
        case .splash:
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .splash:
            return .requestPlain
        case .fcmToken(let serial, let token, _):
            let params = ["serial": serial,
                          "token": token]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        switch self {
        case .fcmToken(_, _, let token):
            return [
                "Authorization": "Bearer \(token)",
                "Accept-Encoding": "gzip, deflate, br",
                "Accept-Language": MOLHLanguage.currentAppleLanguage()
            ]
        default:
            return [
                "Accept-Encoding": "gzip, deflate, br",
                "Accept-Language": MOLHLanguage.currentAppleLanguage()
            ]
        }
    }
}
