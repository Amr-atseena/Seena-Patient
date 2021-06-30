//
//  ServicesListParameters.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 25/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct ServicesListParameters {
    private(set) var limit = 100
    private(set) var offset = 0
    private(set) var search = ""
    private(set) var specialityID : Int?

    init(searchKeyword: String, currentPage: Int , specialityID: Int?) {
        self.offset = currentPage * limit
        self.search = searchKeyword
        self.specialityID = specialityID
    }
}
