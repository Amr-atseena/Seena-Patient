//
//  ClinicsListParameters.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 04/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
struct ClinicsListParameters {
    private(set) var limit = 10
    private(set) var offset = 0
    private(set) var search = ""
    private(set) var specialityId = 0
    private(set) var cityId = 0
    init(specialityId: Int, cityId: Int, searchKeyword: String, currentPage: Int) {
        self.offset = currentPage * limit
        self.search = searchKeyword
        self.specialityId = specialityId
        self.cityId = cityId
    }
}
