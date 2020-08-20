//
//  HomeRouter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class HomeRouter: HomeRouterProtocol {
    // MARK: - Attributes
    var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let view = HomeVC()
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: HomeRoute) {
        switch router {
        case .serviceDetails:
            navigateToServiceDetails()
        case .packageDetails:
            navigateToPackageDetails()
        case .servicesSearch:
            navigateToServicesSearch()
        default:
            print("")
        }
    }
    private func navigateToServiceDetails() {
        viewController?.navigationController?.pushViewController(ServiceDetailsRouter.assembleModule(), animated: true)
    }
    private func navigateToPackageDetails() {
        viewController?.navigationController?.pushViewController(PackageDetailsRouter.assembleModule(), animated: true)
    }
    private func navigateToServicesSearch() {
        viewController?.navigationController?.pushViewController(ServicesSearchRouter.assembleModule(), animated: true)
    }
}
