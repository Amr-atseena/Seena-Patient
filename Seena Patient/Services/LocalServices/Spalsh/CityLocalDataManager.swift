//
//  CityLocalDataManager.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class CityLocalDataManager: CityLocalDataManagerProtocol {
    func save(cities: [City]) {
        let data = try? JSONEncoder().encode(cities)
        UserDefaults.standard.set(data, forKey: "CITY")
    }
    func retriveCities() -> [City] {
        let data = UserDefaults.standard.data(forKey: "CITY")!
        let cities = try? JSONDecoder().decode([City].self, from: data)
        return cities ?? []
    }
}
