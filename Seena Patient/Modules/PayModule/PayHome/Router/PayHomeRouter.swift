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
        }
    }
    private func navigateToPaymentChannel(installment: Installment) {
        viewController?.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(PaymentChannelRouter.assembleModule(), animated: true)
        viewController?.hidesBottomBarWhenPushed = false

    }
}
