//
//  ProfileRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 29/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class ProfileRouter: ProfileRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = ProfileRouter()
        let localDataManager = ProfileLocalDataManager()
        let interactor = ProfileInteractor(localDataManager: localDataManager)
        let view = ProfileVC()
        let presenter = ProfilePresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: ProfileRoute) {
        switch router {
        case .signIn :
            navigateToSignIn()
        }
    }
    private func navigateToSignIn() {
        let signIn = SignInRouter.assembleModule()
        viewController?.navigationController?.setViewControllers([signIn], animated: false)
    }
}
