//
//  AuthenticationEndPoint.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import Moya
enum AuthenticationEndPoint {
    case login(LoginRequestParameters)
    case signUp(SignUpRequestParamaters)
}

// MARK: - TargetType Protocol Implementation
extension AuthenticationEndPoint: TargetType, EnvironmentProtocol {
    var baseURL: URL {
        return apiBaseURL
    }
    var path: String {
        switch self {
        case .login:
            return "auth/login"
        case .signUp:
            return "auth/register"
        }
    }
    var method: Moya.Method {
        return .post
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .login(let params):
            return .requestJSONEncodable(params)
        case .signUp(let params):
            return .requestJSONEncodable(params)
        }
    }
    var headers: [String: String]? {
        return [
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": "en"
        ]
    }
}
