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
        let remoteDataManager = AuthenticationRemoteDataManager()
        let interactor = ProfileInteractor(remoteDataManager: remoteDataManager, localDataManager: localDataManager)
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
        case .applicationStatus:
            navigateToApplicationStatus()
        case .tut:
            tutorials()

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
        let firstActivityItem = "سينا لتقسيط عمليات التجميل والأسنان والسمنة بدون فوائد، بدون مقدم وأقل عمولة في مصر"
        // Setting url
        let secondActivityItem = URL(string: "https://apps.apple.com/eg/app/seena-pay/id1539209003")!
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
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook,
        ]
        viewController?.present(activityViewController, animated: true, completion: nil)
    }
    private func showAlert(alertEntity: AlertEntity) {
        guard let profile = viewController as? ProfileViewProtocol else { return}
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Ok".localized, style: .default) {  (_) in
            profile.presenter.logOut()
        }
        viewController?.showAlertController(title: alertEntity.title, message: alertEntity.message, actions: [okAction, cancelAction])
    }

    private func navigateToApplicationStatus() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ApplicationStatus", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ApplicationStatusViewController") as? ApplicationStatusViewController
        newViewController!.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(newViewController!, animated: true)
    }


    private func tutorials(){
        guard let url = URL(string: "https://www.youtube.com/watch?v=e8OuEbxfpOs&list=PL9e3yBVerJtiNgI8CMI9EOB9AOmY5PLXo&index=3") else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
