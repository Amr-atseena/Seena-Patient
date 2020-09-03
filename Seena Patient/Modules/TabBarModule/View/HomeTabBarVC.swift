//
//  HomeTabBarVC.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class HomeTabBarVC: UITabBarController {
    // MARK: - Attributes
    let localization = TabBarLocalization()
    let customTabBar = CustomizedTabBar()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.modalPresentationStyle = .fullScreen
        self.viewControllers =  [homeModule(), clinicsModule(), payModule(), notificationsModule(), profileModule()]
    }
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = DesignSystem.Colors.primaryBackground.color
        customTabBar.barTintColor = DesignSystem.Colors.secondaryBackground.color
        customTabBar.tintColor = DesignSystem.Colors.selectedTabBar.color
        customTabBar.barTintColor = DesignSystem.Colors.selectedTabBar.color
        customTabBar.unselectedItemTintColor = DesignSystem.Colors.unSelectedTabBar.color
        customTabBar.centerButtonActionHandler = { [weak self] in
            guard let self = self else { return }
            self.selectedIndex = 2
        }
        self.setValue(customTabBar, forKey: "tabBar")
    }
    private func homeModule() -> UIViewController {
        let home = UINavigationController(rootViewController: HomeRouter.assembleModule())
        home.tabBarItem = UITabBarItem(title: localization.home, image: #imageLiteral(resourceName: "Home"), tag: 0)
        return home
    }
    private func clinicsModule() -> UIViewController {
        let clinics = UINavigationController(rootViewController: ClinicsHomeRouter.assembleModule())
        clinics.tabBarItem = UITabBarItem(title: localization.clinics, image: #imageLiteral(resourceName: "Clinics"), tag: 1)
        return clinics
    }
    private func payModule() -> UIViewController {
        let pay = UINavigationController(rootViewController: UIViewController())
        pay.tabBarItem = UITabBarItem()
        return pay
    }
    private func notificationsModule() -> UIViewController {
        let notifications = UINavigationController(rootViewController: NotificationsHomeRouter.assembleModule())
        notifications.tabBarItem = UITabBarItem(title: localization.notifications, image: #imageLiteral(resourceName: "Notifications"), tag: 3)
        return notifications
    }
    private func profileModule() -> UIViewController {
        let profile = UINavigationController(rootViewController: ProfileRouter.assembleModule())
        profile.tabBarItem = UITabBarItem(title: localization.profile, image: #imageLiteral(resourceName: "Profile"), tag: 4)
        return profile
    }
    // MARK: - Actions
    @objc private func didTapPayButton(_ sender: UIButton) {
        self.selectedIndex = 3
    }
}
