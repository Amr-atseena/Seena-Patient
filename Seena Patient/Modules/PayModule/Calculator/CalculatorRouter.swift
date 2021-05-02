//
//  CalculatorRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class CalculatorRouter: CalculatorRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = CalculatorRouter()
        let localDataManager = PaymentLocalDataManager()
        let interactor = CalculatorInteractor(localDataManager: localDataManager)
        let view = CalculatorVC()
        let presenter = CalculatorPresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: CalculatorRoute) {
        switch router {
        case .home:
            navigateToHome()
        }
    }
    private func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
