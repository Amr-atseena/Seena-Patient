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
        let localDataManager = PaymentLocalDataManager()
        let remoteDataManager = PaymentRemoteDataManager()
        let interactor = PayInteractor(localDataManager: localDataManager, remoteDataManager: remoteDataManager)
        let view = PayVC()
        let presenter = PayPresenter(view: view, interactor: interactor, router: router, payment: payment)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: PayRoute) {
        switch router {
        case .paymentChannel:
            navigateToPaymentChannel()
        case .alert(let alertEntity):
        showAlert(alertEntity: alertEntity)
        case .paymentSuccess(let payment):
            navigateToPaymentSuccess(withPayment: payment)
        case .info:
            navigateToInfo()
        }
    }
    private func navigateToPaymentChannel() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    private func showAlert(alertEntity: AlertEntity) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        viewController?.showAlertController(title: alertEntity.title, message: alertEntity.message, actions: [okAction])
    }
    private func navigateToPaymentSuccess(withPayment payment: Payment) {
        let payment = PaymentSuccessRouter.assembleModule(withPayment: payment)
        viewController?.navigationController?.pushViewController(payment, animated: true)
    }
    private func navigateToInfo() {
        let info = InfoVC()
        info.modalTransitionStyle = .crossDissolve
        info.modalPresentationStyle = .overFullScreen
        viewController?.present(info, animated: true, completion: nil)
    }
}
