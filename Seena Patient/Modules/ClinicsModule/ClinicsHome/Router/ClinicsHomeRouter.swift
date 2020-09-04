//
//  ClinicsHomeRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class ClinicsHomeRouter: ClinicsHomeRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = ClinicsHomeRouter()
        let remoteDataManager = ClinicsRomoteDataManager()
        let interactor = ClinicsHomeInteractor(remoteDataManager: remoteDataManager)
        let view = ClinicsHomeVC()
        let presenter = ClinicsHomePresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: ClinicsHomeRoute) {
        switch router {
        case .clinicDetails:
            navigateToClinicDetails()
        case .clincsSearch(let speciality):
            navigateToClinicsSearch(withSpeciality: speciality)
        }
    }
    private func navigateToClinicsSearch(withSpeciality speciality: Speciality) {
        viewController?.navigationController?.pushViewController(ClinicsSearchRouter.assembleModule(withSpeciality: speciality), animated: true)
    }
    private func navigateToClinicDetails() {
        viewController?.navigationController?.pushViewController(ClinicDetailsRouter.assembleModule(withClinic: Clinic(id: 0, image: "", phone: "", name: "", address: "", gallery: [], services: [])), animated: true)
    }
}
