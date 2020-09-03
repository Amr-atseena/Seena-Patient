//
//  ClinicsSearchRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class ClinicsSearchRouter: ClinicsSearchRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = ClinicsSearchRouter()
        let interactor = ClinicsSearchInteractor()
        let view = ClinicsSearchVC()
        let presenter = ClinicsSearchPresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: ClinicsSearchRoute) {
        switch router {
        case .home:
            navigateToHome()
        case .clinicDetails:
            naviagateToClinics()
        }
    }
    private func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    private func naviagateToClinics() {
        viewController?.navigationController?.pushViewController(ClinicDetailsRouter.assembleModule(withClinic: Clinic(id: 0, image: "", phone: "", name: "", address: "", gallery: [], services: [])), animated: true)
    }
}
