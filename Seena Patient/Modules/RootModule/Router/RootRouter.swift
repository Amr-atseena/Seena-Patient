//
//  RootRouter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class RootRouter {
    static func assembleModule(window: UIWindow?) {
        window?.rootViewController  = SplashRouter.assembleModule()
        window?.makeKeyAndVisible()
    }
}
