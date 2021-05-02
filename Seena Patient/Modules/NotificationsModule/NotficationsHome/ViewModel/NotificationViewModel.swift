//
//  NotificationViewModel.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 22/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct NotificationViewModel {
    private(set) var title: String
    private(set) var message: String
    init(notification: Notification) {
        self.title = notification.title
        self.message = notification.message
    }
}
