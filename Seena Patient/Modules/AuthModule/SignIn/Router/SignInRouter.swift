//
//  SignInRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class SignInRouter: SignInRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = SignInRouter()
        let remoteDataManager = AuthenticationRemoteDataManager()
        let localDataManager = AuthenticationLocalDataManager()
        let interactor = SignInInteractor(localDataManager: localDataManager, remoteDataManager: remoteDataManager)
        let view = SignInVC()
        let presenter = SignInPresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: SignInRoute) {
        switch router {
        case .signUp:
            print("sign up")
        case .forgotPassword:
            print(" forgotPassword ")
        case .profile:
            navigateToProfile()
        case .alert(let alertEntity):
            showAlert(alertEntity: alertEntity)
        }
    }
    private func navigateToProfile() {
        viewController?.navigationController?.setViewControllers([ProfileRouter.assembleModule()], animated: true)
    }
    private func showAlert(alertEntity: AlertEntity) {
        let okAction = UIAlertAction(title: "OK", style: .default)
        viewController?.showAlertController(title: alertEntity.title, message: alertEntity.message, actions: [okAction])
    }
}
