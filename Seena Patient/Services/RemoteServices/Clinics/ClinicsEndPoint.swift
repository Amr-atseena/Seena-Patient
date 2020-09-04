//
//  ClinicsEndPoint.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import Moya

enum ClinicsEndPoint {
    case home
    case clinicDetails(clinicId: Int)
    case clinicList(parms: ClinicsListParameters)
}
// MARK: - TargetType Protocol Implementation
extension ClinicsEndPoint: TargetType, EnvironmentProtocol {
    var baseURL: URL {
        return apiBaseURL
    }
    var path: String {
        switch self {
        case .home:
            return "clinic"
        case .clinicDetails(let clinicId):
            return "clinic/\(clinicId)/"
        case .clinicList:
            return "clinic/all"
        }
    }
    var method: Moya.Method {
        switch self {
        case .home:
            return .get
        case .clinicDetails:
            return .get
        case .clinicList:
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
        case .clinicDetails:
            return .requestPlain
        case .clinicList(let parms):
            let parms: [String: Any] = [
                "offset": parms.offset,
                "limit": parms.limit,
                "search": parms.search,
                "cityId": parms.cityId,
                "specialityId": parms.specialityId]
            return .requestParameters(parameters: parms, encoding: URLEncoding.queryString)
        }
    }
    var headers: [String: String]? {
        return [
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": "en"
        ]
    }
}
