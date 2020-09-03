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
    static func assembleModule(withService service: Service) -> UIViewController {
        let remoteDataManager = ServicesRemoteDataManager()
        let interactor = ServiceDetailsInteractor(remoteDataManager: remoteDataManager)
        let view = ServiceDetailsVC()
        let router = ServiceDetailsRouter()
        let presenter = ServiceDetailsPresenter(view: view, interactor: interactor, router: router, service: service)
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
        case .clincDetails(let clinic):
            navigateToClinicDetails(clinic)
        }
    }
    private func navigateToClinicDetails(_ clinic: Clinic) {
        viewController?.navigationController?.pushViewController(ClinicDetailsRouter.assembleModule(), animated: true)
    }
}
