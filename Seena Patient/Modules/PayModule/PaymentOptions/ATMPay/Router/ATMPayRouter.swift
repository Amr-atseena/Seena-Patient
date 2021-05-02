//
//  ATMPayRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class ATMPayRouter: ATMPayRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule(withType type: Int, andInstallment installment: Installment) -> UIViewController {
        let router = ATMPayRouter()
        let localDataManager = PaymentLocalDataManager()
        let interactor = ATMPayInteractor(localDataManager: localDataManager)
        let view = ATMPayVC()
        let presenter = ATMPayPresenter(view: view, interactor: interactor, router: router, type: type, installment: installment)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: ATMPayRoute) {
        switch router {
        case .pay(let pay):
            navigateToPay(payment: pay)
        }
    }
    
    private func navigateToPay(payment: Payment) {
        let payVC = PayRouter.assembleModule(withPayment: payment)
        viewController?.navigationController?.pushViewController(payVC, animated: true)
    }
}
