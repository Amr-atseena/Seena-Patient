//
//  UploadRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class UploadRouter: UploadRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    static var reloadStatus: ((Status) -> Void)?
    // MARK: - Assemble
    static func assembleModule(withDocumentsType type: Int) -> UIViewController {
        let router = UploadRouter()
        let localDataManager = UploadLocalDataManager()
        let remoteDataManager = AuthenticationRemoteDataManager()
        let interactor = UploadInteractor(localDataManager: localDataManager, remoteDataManager: remoteDataManager)
        let view = UploadVC()
        let presenter = UploadPresenter(view: view, interactor: interactor, router: router, documentType: type)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: UploadRoute) {
        switch router {
        case .back(let status):
            navigateUploadDocuments(withStatus: status)
        case .alert(let alertEntity):
            showAlert(alertEntity: alertEntity)
        }
    }
    private func navigateUploadDocuments(withStatus status: Status? = nil) {
        if let stat = status {
            Self.reloadStatus?(stat)
        }
        viewController?.navigationController?.popViewController(animated: true)
    }
    private func showAlert(alertEntity: AlertEntity) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        viewController?.showAlertController(title: alertEntity.title, message: alertEntity.message, actions: [okAction])
    }
}
