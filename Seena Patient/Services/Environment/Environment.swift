//
//  Environment.swift
//  OJO Workforce
//
//  Created by RKAnjel on 8/6/20.
//  Copyright © 2020 Sat Finder. All rights reserved.
//

import Foundation

public enum Environment: String {
    case development  = "DEVELOPMENT"
    case production = "PRODUCTION"
    // MARK: - Current Enviroment
    static var current: Environment {
        let env = UserDefaults.standard.value(forKey: "CurrentEnvironment") as? String
        return Environment(rawValue: env ?? "") ?? .development
    }
    // MARK: - Domain
    var serverMainDomain: String {
        return "157.230.96.195"
    }

    var apiDomain: String {
        switch self {
        case .development:
            return "\(serverMainDomain)/api/"
        case .production:
            return "\(serverMainDomain)/api/"
        }
    }
    // MARK: - URL
    var baseURL: String {
        return "http://\(apiDomain)"
    }
}
