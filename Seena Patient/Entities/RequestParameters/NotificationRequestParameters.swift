//
//  NotificationRequestParameters.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 22/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
struct NotificationRequestParameters {
    private(set) var limit = 10
    private(set) var offset = 0
    private(set) var token = ""
    init(token: String, currentPage: Int) {
        self.offset = currentPage * limit
        self.token = token
    }
}
