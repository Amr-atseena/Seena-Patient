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
        let remoteDataManager = ClinicsRomoteDataManager()
        let interactor = ClinicDetailsInteractor(remoteDataManager: remoteDataManager)
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
        case .serviceDetails(let service):
            navigateToServiesDetails(withService: service)
        case .call(let number):
            makeCall(toNumber: number)
        case let .gallery(image):
            navigateToGalllery(image: image)
        }
    }
    private func navigateToGalllery(image: String) {
        let galleryVC = GalleryVC(image: image)
        galleryVC.modalPresentationStyle = .fullScreen
        viewController?.present(galleryVC, animated: true, completion: nil)
    }
    private func navigateToHome() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    private func navigateToServiesDetails(withService service: Service) {
        viewController?.navigationController?.pushViewController(ServiceDetailsRouter.assembleModule(withService: service), animated: true)
    }
    private func makeCall(toNumber number: String) {
        guard let numberURL =  URL(string: "tel://\(number)") else {
            return
        }
        UIApplication.shared.open(numberURL)
    }
}
