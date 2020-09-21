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
        case .signIn:
            navigateToSignIn()
        case .transactions:
            navigateToTransactions()
        case .settings:
            navigateToSettings()
        case .share:
            share()
        case .alert(let alertEntity):
            showAlert(alertEntity: alertEntity)
        }
    }
    private func navigateToSignIn() {
        let signIn = SignInRouter.assembleModule()
        viewController?.navigationController?.setViewControllers([signIn], animated: false)
    }
    private func navigateToTransactions() {
        let transaction = TransactionsRouter.assembleModule()
        viewController?.navigationController?.pushViewController(transaction, animated: true)
    }
    private func navigateToSettings() {
        let settings = SettingsRouter.assembleModule()
        viewController?.navigationController?.pushViewController(settings, animated: true)
    }
    private func share() {
        // Setting description
        let firstActivityItem = "لتقسيط عمليات التجميل والأسنان والسمنة"
        // Setting url
        let secondActivityItem = URL(string: "https://ar.seenapay.com/")!
        // If you want to use an image
        let image  = #imageLiteral(resourceName: "Seena-Logo")
        let activityViewController  = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        // Pre-configuring activity items
//        activityViewController.activityItemsConfiguration = [
//        UIActivity.ActivityType.message
//        ] as? UIActivityItemsConfigurationReading
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        viewController?.present(activityViewController, animated: true, completion: nil)
    }
    private func showAlert(alertEntity: AlertEntity) {
        guard let profile = viewController as? ProfileViewProtocol else { return}
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default) {  (_) in
            profile.presenter.logOut()
        }
        viewController?.showAlertController(title: alertEntity.title, message: alertEntity.message, actions: [okAction, cancelAction])
    }
}
