//
//  PayHomeRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 06/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class PayHomeRouter: PayHomeRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = PayHomeRouter()
        let localDataManager = PaymentLocalDataManager()
        let remoteDataManager = PaymentRemoteDataManager()
        let interactor = PayHomeInteractor(localDataManager: localDataManager, remoteDataManager: remoteDataManager)
        let view = PayHomeVC()
        let presenter = PayHomePresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: PayHomeRoute) {
        switch router {
        case .paymentChannel(let installment):
            navigateToPaymentChannel(installment: installment)
        case .calculate:
            navigateToCalculate()

        case .notActive:
            notActivee()

        }
    }
    private func navigateToPaymentChannel(installment: Installment) {
        viewController?.tabBarController?.tabBar.isHidden = true
        viewController?.navigationController?.pushViewController(PaymentChannelRouter.assembleModule(withInstallment: installment), animated: true)
    }
    private func navigateToCalculate() {
        viewController?.tabBarController?.tabBar.isHidden = true
        viewController?.navigationController?.pushViewController(CalculatorRouter.assembleModule(), animated: true)
    }

    private func notActivee() {
        viewController?.showAlertController(title: "Attention!".toLocalize, message: "You can pay only current unpaid and rejected installments".toLocalize, actions: [])
//        viewController?.showToast(message: "You can pay only current unpaid and rejected installments".toLocalize, font: .systemFont(ofSize: 15))
    }
}
