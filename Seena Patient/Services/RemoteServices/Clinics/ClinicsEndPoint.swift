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
    case clinicDetails(clinicId: Int)
}
// MARK: - TargetType Protocol Implementation
extension ClinicsEndPoint: TargetType, EnvironmentProtocol {
    var baseURL: URL {
        return apiBaseURL
    }
    var path: String {
        switch self {
        case .clinicDetails(let clinicId) :
            return "clinic/\(clinicId)/"
        }
    }
    var method: Moya.Method {
        switch self {
        case .clinicDetails:
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .clinicDetails:
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
