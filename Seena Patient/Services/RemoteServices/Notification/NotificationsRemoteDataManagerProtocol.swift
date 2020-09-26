//
//  NotificationsRemoteDataManagerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 22/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
protocol NotificationsRemoteDataManagerProtocol: class {
    func retriveNotificationsList(parameters: NotificationRequestParameters ,completionHandler: @escaping ((_ result: Result<Codable, Error>) -> Void))
}
