//
//  HomeTabBarVC.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import MOLH

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
            let isSigned = UserDefaults.standard.bool(forKey: "Signin")






            if isSigned == true {
                let userStatus = UserDefaults.standard.string(forKey: "status")

                APIClient().getUserStatus { (res) in
                    print(res.response.isEnabled)
                    if res.response.isEnabled == "Enabled"{
                        guard let self = self else { return }
                        self.selectedIndex = 2
                    }else{
                        if MOLHLanguage.isArabic(){
                            self?.showAlertController(title: "Alert!".toLocalize, message: res.response.messageAr, actions: [])
                        }else{
                            self?.showAlertController(title: "Alert!".toLocalize, message: res.response.message, actions: [])
                        }
                    }
                } onError: { (error) in
                    print(error)
                }


            }else{
                self?.showAlertController(title: "Alert!".toLocalize, message: "Please, sign in first".toLocalize, actions: [])
            }
        }
        self.setValue(customTabBar, forKey: "tabBar")
    }
    private func homeModule() -> UIViewController {
        let home = UINavigationController(rootViewController: HomeRouter.assembleModule())
        home.tabBarItem = UITabBarItem(title: localization.home, image: #imageLiteral(resourceName: "home"), tag: 0)
        return home


        //                let pay = UINavigationController(rootViewController: PayHomeRouter.assembleModule())
        //                pay.tabBarItem = UITabBarItem(title: localization.home, image: #imageLiteral(resourceName: "home"), tag: 0)
        //                return pay
    }
    
    private func clinicsModule() -> UIViewController {
        //        let clinics = UINavigationController(rootViewController: ClinicsHomeRouter.assembleModule())
        //        clinics.tabBarItem = UITabBarItem(title: localization.clinics, image: #imageLiteral(resourceName: "Clinics"), tag: 1)
        //        return clinics
        //        let home = UINavigationController(rootViewController: HomeRouter.assembleModule())
        //        home.tabBarItem = UITabBarItem(title: localization.clinics, image: #imageLiteral(resourceName: "Clinics"), tag: 1)
        //        return home

        let pay = UINavigationController(rootViewController: PayHomeRouter.assembleModule())
        pay.tabBarItem = UITabBarItem(title: "Wallet".toLocalize, image: UIImage(named: "wallet"), tag: 0)
        return pay

    }
    private func payModule() -> UIViewController {
        //        let pay = UINavigationController(rootViewController: PayHomeRouter.assembleModule())
        //        pay.tabBarItem = UITabBarItem()
        //        return pay


        let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CheckoutViewController") as? CheckoutViewController
        newViewController!.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(newViewController!, animated: true)
        return newViewController!



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
