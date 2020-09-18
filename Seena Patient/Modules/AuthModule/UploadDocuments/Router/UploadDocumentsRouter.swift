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
        let presenter = UploadDocumentsPresenter(view: view, interactor: interactor, router: router,status: status)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: UploadDocumentsRoute) {
    }
}
