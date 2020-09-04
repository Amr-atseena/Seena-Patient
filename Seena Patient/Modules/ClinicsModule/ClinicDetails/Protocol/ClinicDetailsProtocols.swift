//
//  ClinicDetailsProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ClinicDetails Router
enum ClinicDetailsRoute {
    case clinicHome
    case serviceDetails(service: Service)
    case call(number: String)
}
protocol ClinicDetailsRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: ClinicDetailsRoute)
    static func assembleModule(withClinic clinic: Clinic) -> UIViewController
}
// MARK: - ClinicDetails Interactor
protocol ClinicDetailsInputInteractorProtocol: class {
    var remoteDataManager: ClinicsRemoteDataManangerProtocol { get set }
    var presenter: ClinicDetailsOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
    func retriveClinicDetails(atClinicId clinicId: Int)
}
protocol ClinicDetailsOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveClinicSuccess(_ clinic: Clinic)
    func onRetriveDataFail()
}
// MARK: - ClinicDetails Preseneter
protocol ClinicDetailsPresenterProtocol: class {
    var view: ClinicDetailsViewProtocol? { get set}
    var interactor: ClinicDetailsInputInteractorProtocol? { get set}
    var router: ClinicDetailsRouterProtocol? { get set }
    var localization: ClinicDetailsLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func callButtonTapped()
    func backButtonTapped()
    func galleryCollectionView(selectedAtIndex index: Int)
    func serviesCollectionView(selectedAtIndex index: Int)
    func config(serviceCell cell: ServiceCellProtocol, atIndex index: Int)
    func config(galleryCell cell: GalleryCellProtocol, atIndex index: Int)
    var numberOfImages: Int { get }
    var numberOfServices: Int { get }
}
// MARK: - ClinicDetails View
protocol ClinicDetailsViewProtocol: class {
    var presenter: ClinicDetailsPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setupGalleryCollectionView()
    func setupServicesCollectionView()
    func updateUI(withClinic clinic: ClinicViewModel)
    func reloadGallery()
    func reloadServices()
    func showSkelton()
    func hideSkeleton()
}
// MARK: - GalleryCell View
protocol GalleryCellProtocol: class {
    func set(gallery: GalleryViewModel)
}
