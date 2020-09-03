//
//  ClinicDetailsRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class ClinicDetailsRouter: ClinicDetailsRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule(withClinic clinic: Clinic) -> UIViewController {
        let router = ClinicDetailsRouter()
        let interactor = ClinicDetailsInteractor()
        let view = ClinicDetailsVC()
        let presenter = ClinicDetailsPresenter(view: view, interactor: interactor, router: router, clinic: clinic)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: ClinicDetailsRoute) {
        switch router {
        case .clinicHome:
            navigateToHome()
        case .serviceDetails:
            navigateToServiesDetails(withService: Service(seriveId: 0, image: "", name: "", specialityID: 0, serviceDescription: "", priceMin: 0, priceMax: 0, clinics: []))
        }
    }
    private func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    private func navigateToServiesDetails(withService service: Service) {
        viewController?.navigationController?.pushViewController(ServiceDetailsRouter.assembleModule(withService: service), animated: true)
    }
}
