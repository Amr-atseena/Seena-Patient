//
//  TokenLocalDataManagerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
protocol TokenLocalDataManagerProtocol: class {
    func save(token: String)
    func retriveToken() -> String
}
extension UserLocalDataManagerProtocol {
    func save(token: String) {
        UserDefaults.standard.set(token, forKey: "TOKEN")
    }
    func retriveToken() -> String {
        return UserDefaults.standard.string(forKey: "TOKEN") ?? ""
    }
}
