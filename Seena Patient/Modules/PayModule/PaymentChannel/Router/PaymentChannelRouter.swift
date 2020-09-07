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
    static func assembleModule() -> UIViewController {
        let router = PaymentChannelRouter()
        let interactor = PaymentChannelInteractor()
        let view = PaymentChannelVC()
        let presenter = PaymentChannelPresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: PaymentChannelRoute) {
    }
}
