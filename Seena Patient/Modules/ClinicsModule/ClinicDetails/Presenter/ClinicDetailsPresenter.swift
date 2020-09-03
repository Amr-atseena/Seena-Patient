//
//  ClinicDetailsPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ClinicDetailsPresenter: ClinicDetailsPresenterProtocol {
    // MARK: - Attributes
    weak var view: ClinicDetailsViewProtocol?
    var interactor: ClinicDetailsInputInteractorProtocol?
    var router: ClinicDetailsRouterProtocol?
    let localization = ClinicDetailsLocalization()
    private var clinic: Clinic {
        didSet {
            services = clinic.services ?? []
            gallery = clinic.gallery ?? []
        }
    }
    private var services: [Service] = [] {
        didSet {
            view?.reloadServices()
        }
    }
    private var gallery: [Gallery] = [] {
        didSet {
            view?.reloadGallery()
        }
    }
    var numberOfImages: Int {
        return gallery.count
    }
    var numberOfServices: Int {
        return services.count
    }
    // MARK: - Init
    init(view: ClinicDetailsViewProtocol,
         interactor: ClinicDetailsInputInteractorProtocol,
         router: ClinicDetailsRouterProtocol,
         clinic: Clinic) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.clinic = clinic
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setupGalleryCollectionView()
        view?.setupServicesCollectionView()
        view?.updateUI(withClinic: ClinicViewModel(clinic: clinic))
    }
    func callButtonTapped() {
    }
    func backButtonTapped() {
        router?.go(to: .clinicHome)
    }
    func galleryCollectionView(selectedAtIndex index: Int) {
      //  router?.go(to: .)
    }
    func serviesCollectionView(selectedAtIndex index: Int) {
        router?.go(to: .serviceDetails)
    }
    func config(serviceCell cell: ServiceCellView, atIndex index: Int) {
    }
    func config(galleryCell cell: ServiceCellView, atIndex index: Int) {
    }
}
// MARK: - ClinicDetailsOutputInteractorProtocol Implementation
extension ClinicDetailsPresenter: ClinicDetailsOutputInteractorProtocol {
    func onRetriveClinicSuccess(_ clinic: Clinic) {
    }
    func onRetriveDataFail() {
    }
}
