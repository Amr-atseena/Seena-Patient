//
//  UploadDocumentsRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class UploadDocumentsRouter: UploadDocumentsRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule(withStatus status: Status) -> UIViewController {
        let router = UploadDocumentsRouter()
        let interactor = UploadDocumentsInteractor()
        let view = UploadDocumentsVC()
        let presenter = UploadDocumentsPresenter(view: view, interactor: interactor, router: router, status: status)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: UploadDocumentsRoute) {
        switch router {
        case .back:
            navigateToback()
        case .upload(let index):
            navigateToUpload(withDocumentTypeIndex: index)
        case .finishSignUp:
            navigateToFinishSignUp()
        }
    }
    private func navigateToback() {

        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Ok".localized, style: .default) {  (_) in
            self.viewController?.navigationController?.popViewController(animated: true)
        }
        viewController?.showAlertController(title: "Warning".toLocalize, message: "You will lose any progress you have done.".toLocalize, actions: [okAction, cancelAction])

    }
    private func navigateToFinishSignUp() {
        
//        viewController?.navigationController?.setViewControllers([FinishSignUpVC()], animated: true)


        // I make this navi to hide bottom toolbar
        let aaaaa = FinishSignUpVC()
        aaaaa.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(aaaaa, animated: true)


    }
    private func navigateToUpload(withDocumentTypeIndex index: Int) {
        guard let uploadDoc = viewController as? UploadDocumentsViewProtocol else {
            return
        }
        let uploadVC = UploadRouter.assembleModule(withDocumentsType: index)
        UploadRouter.reloadStatus = { (status) in
            uploadDoc.presenter.updateStatus(status)
        }
        
        viewController?.navigationController?.pushViewController(uploadVC, animated: true)
    }
}
