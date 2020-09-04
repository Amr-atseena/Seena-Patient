//
//  UIViewContorller+Extension.swift
//  Breeders
//
//  Created by RKAnjel on 5/13/20.
//  Copyright © 2020 SatFinder. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func configureNavigationBar(titleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor, .font: DesignSystem.Typography.heading.font]
            navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor, .font: DesignSystem.Typography.subHeading2.font]
            navBarAppearance.backgroundColor = backgoundColor
            navBarAppearance.shadowColor = nil
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.title = title
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgoundColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = true
            navigationItem.title = title
        }
    }
    func showAlertController(title: String, message: String,actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
            alert.addAction(okAction)
        }else {
            for action in actions {
                alert.addAction(action)
            }
        }
        self.present(alert,animated: true)
    }
}
