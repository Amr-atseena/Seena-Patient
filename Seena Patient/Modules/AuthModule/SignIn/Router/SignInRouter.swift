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
            navigateToSignUp()
        case .uploadDocuments(let status):
            navigateToUploadDocumets(withStatus: status)
        case .forgotPassword:
            print(" forgotPassword ")
            navigateToForgetPass()
        case .profile:
            navigateToProfile()
        case .alert(let alertEntity):
            showAlert(alertEntity: alertEntity)
        }
    }
    private func navigateToProfile() {
        viewController?.navigationController?.setViewControllers([ProfileRouter.assembleModule()], animated: true)
    }
    private func navigateToSignUp() {
        viewController?.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(SignUpRouter.assembleModule(), animated: true)
        viewController?.hidesBottomBarWhenPushed = false
    }
    private func navigateToUploadDocumets(withStatus status: Status) {
        let uploadDocuments = UploadDocumentsRouter.assembleModule(withStatus: status)
        viewController?.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(uploadDocuments, animated: true)
        viewController?.hidesBottomBarWhenPushed = false
    }
    private func showAlert(alertEntity: AlertEntity) {
        let okAction = UIAlertAction(title: "OK", style: .default)
        viewController?.showAlertController(title: alertEntity.title, message: alertEntity.message, actions: [okAction])
    }

    private func navigateToForgetPass() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ForgetPassword", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ForgetPassViewController") as? ForgetPassViewController
        newViewController!.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(newViewController!, animated: true)
//        viewController?.present(newViewController!, animated: true, completion: nil)
    }
}
