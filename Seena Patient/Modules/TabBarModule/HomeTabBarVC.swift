//
//  HomeTabBarVC.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class HomeTabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.modalPresentationStyle = .fullScreen
        self.viewControllers =  [shopVC(), offersVC(), breedersVC(), auctionsVC(), moreVC()]
    }
    private func setupUI() {
        let customTabBar = CustomizedTabBar()
//        customTabBar.layer.cornerRadius = 20
//        customTabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        customTabBar.clipsToBounds = true
//        let button = UIButton()
//        button.setTitle("PAY", for: .normal)
//        button.backgroundColor = .red
//        button.translatesAutoresizingMaskIntoConstraints = false
//        customTabBar.insertSubview(button, at: 0)
//        button.widthAnchor.constraint(equalToConstant: 65).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 65).isActive = true
//        customTabBar.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
//        customTabBar.topAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
//        button.layer.cornerRadius = 32.5
//        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(didTapPayButton(_:)), for: .touchUpInside)
        view.backgroundColor = DesignSystem.Colors.primaryBackground.color
        customTabBar.barTintColor = DesignSystem.Colors.secondaryBackground.color
        customTabBar.tintColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
        customTabBar.barTintColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
        customTabBar.centerButtonActionHandler = {
            self.selectedIndex = 2
        }
        customTabBar.unselectedItemTintColor = #colorLiteral(red: 0.4666666667, green: 0.5254901961, blue: 0.6196078431, alpha: 1)
        self.setValue(customTabBar, forKey: "tabBar")
    }
    @objc func didTapPayButton(_ sender: UIButton) {
        self.selectedIndex = 3
    }
    private func shopVC() -> UIViewController {
        let shopVC = UINavigationController(rootViewController: UIViewController())
        shopVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Shop", comment: ""), image: #imageLiteral(resourceName: "Home"), tag: 0)
        return shopVC
    }
    private func offersVC() -> UIViewController {
        let offersVC = UINavigationController(rootViewController: UIViewController())
        offersVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Offers", comment: ""), image: #imageLiteral(resourceName: "Clinics"), tag: 1)
        return offersVC
    }
    private func breedersVC() -> UIViewController {
        let breedersVC = UINavigationController(rootViewController: UIViewController())
        breedersVC.tabBarItem = UITabBarItem()
        return breedersVC
    }
    private func auctionsVC() -> UIViewController {
        let auctionsVC = UINavigationController(rootViewController: UIViewController())
        auctionsVC.tabBarItem = UITabBarItem(title: NSLocalizedString("Auctions", comment: ""), image: #imageLiteral(resourceName: "Notifications"), tag: 3)
        return auctionsVC
    }
    private func moreVC() -> UIViewController {
        let moreVC = UINavigationController(rootViewController: UIViewController())
        moreVC.tabBarItem = UITabBarItem(title: NSLocalizedString("More", comment: ""), image: #imageLiteral(resourceName: "Profile"), tag: 4)
        return moreVC
    }

}
