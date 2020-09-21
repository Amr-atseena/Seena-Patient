//
//  TransactionsRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class TransactionsRouter: TransactionsRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = TransactionsRouter()
        let interactor = TransactionsInteractor()
        let view = TransactionsVC()
        let presenter = TransactionsPresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: TransactionsRoute) {
        switch router {
        case .back:
            navigateToBack()
        }
    }
    private func navigateToBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
