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
    static func assembleModule(type : Int) -> UIViewController {
        let router = ServicesSearchRouter()
        let remoteServices = ServicesRemoteDataManager()
        let interactor = ServicesSearchInteractor(remoteDataServices: remoteServices)
        let view = ServicesSearchVC()
        let presenter = ServicesSearchPresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        view.type = type
        return view
    }
    // MARK: - Routing
    func go(to router: ServicesSearchRoute) {
        switch router {
        case .home:
            navigateToHome()
        case .serviceDetails(let service):
            navigateToService(withService: service)
        }
    }
    private func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    private func navigateToService(withService service: Service) {
        viewController?.navigationController?.pushViewController(ServiceDetailsRouter.assembleModule(withService: service), animated: true)
    }
}
