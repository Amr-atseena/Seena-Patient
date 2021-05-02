//
//  RootRouter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import FirebaseMessaging
class RootRouter {
    static func assembleModule(window: UIWindow?) {
        let token = Messaging.messaging().fcmToken ?? ""
        let serial = UIDevice.current.identifierForVendor?.uuidString ?? ""
        window?.rootViewController  = SplashRouter.assembleModule(serial: serial, token: token)
        window?.makeKeyAndVisible()
    }
}
