//
//  AppDelegate.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Attributes
    var window: UIWindow?
    // MARK: - Life Cycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        setupIQKeyboardManager()
        setupNavBarApperance()
        setupTabBarApperance()
        RootRouter.assembleModule(window: window)
        return true
    }
    // MARK: - Methods
    private func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    private func setupNavBarApperance() {
    }
    private func setupTabBarApperance() {
    }
}
