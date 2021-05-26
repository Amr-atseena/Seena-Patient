//
//  HomeRouter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class HomeRouter: HomeRouterProtocol {
    // MARK: - Attributes
    var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = HomeRouter()
        let remoteDataServies = ServicesRemoteDataManager()
        let localDataManager = ServicesLocalDataManager()
        let interactor = HomeInteractor(localDataManager: localDataManager, remoteServices: remoteDataServies)
        let view = HomeVC()
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: HomeRoute) {
        switch router {
        case .serviceDetails(let service):
            navigateToServiceDetails(service)
        case .packageDetails(let package):
            navigateToPackageDetails(withPackage: package)
        case .servicesSearch:
            navigateToServicesSearch()
        case .specialities(let spec):
            navigateToServiceDetails(withSpeciality: spec)

        case .clincss(let cli):
            navigateToClinicDetails(withClinic: cli)

        default:
            print("")
        }
    }
    private func navigateToServiceDetails(_ service: Service) {
        viewController?.navigationController?.pushViewController(ServiceDetailsRouter.assembleModule(withService: service), animated: true)
    }
    private func navigateToPackageDetails(withPackage package: Package) {
        viewController?.navigationController?.pushViewController(PackageDetailsRouter.assembleModule(withPackage: package), animated: true)
    }
    private func navigateToServicesSearch() {
        viewController?.navigationController?.pushViewController(ServicesSearchRouter.assembleModule(), animated: true)
    }
    private func navigateToServiceDetails(withSpeciality speciality: Speciality) {
        viewController?.navigationController?.pushViewController(ClinicsSearchRouter.assembleModule(withSpeciality: speciality), animated: true)
    }

    private func navigateToClinicDetails(withClinic clinic: Clinic) {
        viewController?.navigationController?.pushViewController(ClinicDetailsRouter.assembleModule(withClinic: clinic), animated: true)
    }
}
