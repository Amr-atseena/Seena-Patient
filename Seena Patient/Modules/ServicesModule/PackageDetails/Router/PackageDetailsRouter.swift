//
//  PackageDetailsRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class PackageDetailsRouter: PackageDetailsRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule(withPackage package: Package) -> UIViewController {
        let router = PackageDetailsRouter()
        let interactor = PackageDetailsInteractor()
        let view = PackageDetailsVC()
        let presenter = PackageDetailsPresenter(view: view, interactor: interactor, router: router, package: package)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: PackageDetailsRoute) {
        switch router {
        case .home:
            naviagateToHome()
        case .serviceDetails:
            print("")
        }
    }
    private func naviagateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
