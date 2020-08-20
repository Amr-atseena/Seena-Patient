//
//  ServiceDetailsRouter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/16/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class ServiceDetailsRouter: ServiceDetailsRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let view = ServiceDetailsVC()
        let interactor = ServiceDetailsInteractor()
        let router = ServiceDetailsRouter()
        let presenter = ServiceDetailsPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    // MARK: - Routing
    func go(to router: ServiceDetailsRoute) {
        switch router {
        case .home:
            viewController?.navigationController?.popViewController(animated: true)
        default:
            print("")
        }
    }
}
