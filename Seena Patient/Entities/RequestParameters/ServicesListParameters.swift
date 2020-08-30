//
//  ServicesListParameters.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 25/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct ServicesListParameters {
    private(set) var limit = 10
    private(set) var offset = 0
    private(set) var search = ""
    init(searchKeyword: String, currentPage: Int) {
        self.offset = currentPage * limit
        self.search = searchKeyword
    }
}
