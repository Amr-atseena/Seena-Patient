//
//  NotificationsRemoteDataManager.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 22/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
class NotificationsRemoteDataManager: APIService<NotificationEndPoint>, NotificationsRemoteDataManagerProtocol {
    func retriveNotificationsList(parameters: NotificationRequestParameters, completionHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        request(target: .notifications(parameters), objType: BaseResponse<[Notification]>.self, completionHandler: completionHandler)
    }
}
