//
//  ServiceDetailsProtocols.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/16/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ServiceDetails Router
enum ServiceDetailsRoute {
    case clincDetails(clinic: Clinic)
    case home
}
protocol ServiceDetailsRouterProtocol: class {
    var viewController: UIViewController? { get set }
    func go(to router: ServiceDetailsRoute)
    static func assembleModule(withService service: Service) -> UIViewController
}
// MARK: - ServiceDetails Interactor
protocol ServiceDetailsInputInteractorProtocol: class {
    var presenter: ServiceDetailsOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
    func retriveServiceDetails(atServiceId serviceId: Int)
}
protocol ServiceDetailsOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveDataSuccess(withService service: Service)
    func onRetriveDataFail()
}
// MARK: - ServiceDetails Presenter
protocol ServiceDetailsPresenterProtocol: class {
    var router: ServiceDetailsRouterProtocol? { get set }
    var interactor: ServiceDetailsInputInteractorProtocol? { get set }
    var view: ServiceDetailsViewProtocol? { get set }
    var localization: ServiceDetailsLocalizaition { get }
    // View -> Presenter
    func viewDidLoad()
    func shareButtonTapped()
    func backButtonTapped()
    func config(clinicCell cell: ClinicCellView, atIndex index: Int)
    func didSelectClinic(atIndex index: Int)
    var numberOfClinics: Int { get }
}
// MARK: - ServiceDetails View
protocol ServiceDetailsViewProtocol: class {
    var presenter: ServiceDetailsPresenterProtocol! { get set }
    // Presenter -> View
    func setupNavBar()
    func setupUI()
    func setupClinicsCollectionView()
    func updateUI(withService service: ServiceViewModel)
    func reloadClinics()
    func showSkelton()
    func hideSkelton()
}
// MARK: - ClinicCell View
protocol ClinicCellView {
    func setClinic(_ clinic: ClinicViewModel)
}
