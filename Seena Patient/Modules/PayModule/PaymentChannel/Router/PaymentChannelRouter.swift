//
//  PaymentChannelRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 07/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class PaymentChannelRouter: PaymentChannelRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule(withInstallment installment: Installment) -> UIViewController {
        let router = PaymentChannelRouter()
        let interactor = PaymentChannelInteractor()
        let view = PaymentChannelVC()
        let presenter = PaymentChannelPresenter(view: view, interactor: interactor, router: router, installment: installment)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: PaymentChannelRoute) {
        switch router {
        case .atm(let type, let installment):
            navigateToATM(withType: type, andInstallment: installment)
        case .payHome:
            navigateToPayHome()
        case let .alert(alertEntity):
            showAlert(alertEntity: alertEntity)
        }
    }
    private func navigateToPayHome() {
        viewController?.tabBarController?.tabBar.isHidden = false
        viewController?.navigationController?.popViewController(animated: true)
    }
    private func navigateToATM(withType type: Int, andInstallment installment: Installment) {
        removeChildsVC()
        guard let parent = viewController as? PaymentChannelVC else { return }
        let child = ATMPayRouter.assembleModule(withType: type, andInstallment: installment)
        parent.containerView.addSubview(child.view)
        child.view.frame = parent.containerView.bounds
        parent.addChild(child)
        child.didMove(toParent: parent)
    }
    private func removeChildsVC() {
        viewController?.children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
    private func showAlert(alertEntity: AlertEntity) {
        viewController?.showAlertController(title: alertEntity.title, message: alertEntity.message, actions: [])
    }
}
