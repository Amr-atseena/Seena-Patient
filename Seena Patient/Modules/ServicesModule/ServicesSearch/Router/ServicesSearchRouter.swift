//
//  ServicesSearchRouter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/17/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class ServicesSearchRouter: ServicesSearchRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = ServicesSearchRouter()
        let interactor = ServicesSearchInteractor()
        let view = ServicesSearchVC()
        let presenter = ServicesSearchPresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: ServicesSearchRoute) {
        switch router {
        case .home:
            navigateToHome()
        }
    }
    private func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
