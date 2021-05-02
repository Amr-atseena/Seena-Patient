//
//  PaymentSuccessRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class PaymentSuccessRouter: PaymentSuccessRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule(withPayment payment: Payment) -> UIViewController {
        let router = PaymentSuccessRouter()
        let interactor = PaymentSuccessInteractor()
        let view = PaymentSuccessVC()
        let presenter = PaymentSuccessPresenter(view: view, interactor: interactor, router: router, payment: payment)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: PaymentSuccessRoute) {
        switch router {
        case .home:
            navigateToHome()
        }
    }
    private func navigateToHome() {
        viewController?.tabBarController?.tabBar.isHidden = false
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
