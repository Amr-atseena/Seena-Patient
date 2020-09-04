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
    static func assembleModule(withSpeciality speciality: Speciality) -> UIViewController {
        let router = ClinicsSearchRouter()
        let localDataManager = ClinicsSearchLocalDataManager()
        let remoteDataManager = ClinicsRomoteDataManager()
        let interactor = ClinicsSearchInteractor(localDataManager: localDataManager, remoteDataManager: remoteDataManager)
        let view = ClinicsSearchVC()
        let presenter = ClinicsSearchPresenter(view: view, interactor: interactor, router: router, speciality: speciality)
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
        case .clinicDetails(let clinic):
            naviagateToClinics(withClinic: clinic)
        case .call(let number):
            makeCall(toNumber: number)
        }
    }
    private func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    private func naviagateToClinics(withClinic clinic: Clinic) {
        viewController?.navigationController?.pushViewController(ClinicDetailsRouter.assembleModule(withClinic: clinic), animated: true)
    }
    private func makeCall(toNumber number: String) {
        guard let numberURL =  URL(string: "tel://\(number)") else { return }
        UIApplication.shared.open(numberURL)
    }
}
