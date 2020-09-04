//
//  ServicesEndPoint.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import Moya
enum ServicesEndPoint {
    case home
    case servicesList(parms: ServicesListParameters)
    case serviceDetails(serviceId: Int)
}

// MARK: - TargetType Protocol Implementation
extension ServicesEndPoint: TargetType, EnvironmentProtocol {
    var baseURL: URL {
        return apiBaseURL
    }
    var path: String {
        switch self {
        case .home:
            return "home"
        case .servicesList:
            return "services"
        case .serviceDetails(let serviceId):
            return "services/\(serviceId)/"
        }
    }
    var method: Moya.Method {
        switch self {
        case .home:
            return .get
        case .servicesList:
            return .get
        case .serviceDetails:
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .home:
            return .requestPlain
        case .servicesList(let parms):
            let parms: [String: Any] = [
                "offset": parms.offset,
                "limit": parms.limit,
                "search": parms.search]
            return .requestParameters(parameters: parms, encoding: URLEncoding.queryString)
        case .serviceDetails:
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
