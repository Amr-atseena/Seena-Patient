//
//  SettingsRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class SettingsRouter: SettingsRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = SettingsRouter()
        let interactor = SettingsInteractor()
        let view = SettingsVC()
        let presenter = SettingsPresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: SettingsRoute) {
        switch router {
        case .back:
            navigateBack()
        case .alert(let alertEntity):
            showAlert(alertEntity: alertEntity)
        }
    }
    private func showAlert(alertEntity: AlertEntity) {
    }
    private func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
