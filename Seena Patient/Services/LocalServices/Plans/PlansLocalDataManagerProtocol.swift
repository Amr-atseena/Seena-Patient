//
//  PlansLocalDataManagerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

protocol PlansLocalDataManagerProtocol {
    func save(plans: [Plan])
    func retrivePlans() -> [Plan]
}
extension PlansLocalDataManagerProtocol {
    func save(plans: [Plan]) {
        let data = try? JSONEncoder().encode(plans)
        UserDefaults.standard.set(data, forKey: "PLANS")
    }
    func retrivePlans() -> [Plan] {
        let data = UserDefaults.standard.data(forKey: "PLANS")!
        let plans = try? JSONDecoder().decode([Plan].self, from: data)
        return plans ?? []
    }
}
