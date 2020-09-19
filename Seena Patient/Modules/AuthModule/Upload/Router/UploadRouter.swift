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
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = UploadRouter()
        let interactor = UploadInteractor()
        let view = UploadVC()
        let presenter = UploadPresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: UploadRoute) {
        switch router {
        case .back:
            navigateUploadDocuments()
        }
    }
    private func navigateUploadDocuments(withStatus status: Status? = nil) {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
