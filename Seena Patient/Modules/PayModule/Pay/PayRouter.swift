//
//  PayRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class PayRouter: PayRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule(withPayment payment: Payment) -> UIViewController {
        let router = PayRouter()
        let interactor = PayInteractor()
        let view = PayVC()
        let presenter = PayPresenter(view: view, interactor: interactor, router: router, payment: payment)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: PayRoute) {
        switch router{
        case .paymentChannel:
            navigateToPaymentChannel()
        }
    }
    private func navigateToPaymentChannel() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
