//
//  UINavigationController+Extension.swift
//  Breeders
//
//  Created by RKAnjel on 5/5/20.
//  Copyright © 2020 SatFinder. All rights reserved.
//

import UIKit

extension UINavigationController {
    func pushViewControllerWithModalTransition(viewController: UIViewController) {
        setupPushTransition()
        self.pushViewController(viewController, animated: false)
    }
    func setupPushTransition () {
        let transition: CATransition = CATransition()
        transition.duration = 0.75
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.view.layer.add(transition, forKey: kCATransition)
    }
    func popViewControllerWithModalTransition() {
        setupPopTransition()
        self.popViewController(animated: false)
    }
    func setupPopTransition () {
        let transition: CATransition = CATransition()
        transition.duration = 0.75
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.layer.add(transition, forKey: kCATransition)
    }
    func pushViewControllerWithOutBackButton(viewController: UIViewController, animated: Bool) {
        self.setViewControllers([viewController], animated: animated)
    }
}
