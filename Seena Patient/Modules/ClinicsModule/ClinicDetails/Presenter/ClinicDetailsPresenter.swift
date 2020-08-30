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
    var numberOfImages: Int {
        return 10
    }
    var numberOfServices: Int {
        return 10
    }
    // MARK: - Init
    init(view: ClinicDetailsViewProtocol?, interactor: ClinicDetailsInputInteractorProtocol, router: ClinicDetailsRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setupGalleryCollectionView()
        view?.setupServicesCollectionView()
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
}
// MARK: - ClinicDetailsOutputInteractorProtocol Implementation
extension ClinicDetailsPresenter: ClinicDetailsOutputInteractorProtocol {
}
