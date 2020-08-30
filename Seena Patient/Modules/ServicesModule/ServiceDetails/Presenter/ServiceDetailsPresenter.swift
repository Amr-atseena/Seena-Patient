//
//  ServiceDetailsPresenter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/16/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ServiceDetailsPresenter: ServiceDetailsPresenterProtocol {
    // MARK: - Attributes
    var router: ServiceDetailsRouterProtocol?
    var interactor: ServiceDetailsInputInteractorProtocol?
    weak var view: ServiceDetailsViewProtocol?
    let localization = ServiceDetailsLocalizaition()
    let service: Service
    // MARK: - Init
    init(view: ServiceDetailsViewProtocol, interactor: ServiceDetailsInputInteractorProtocol, router: ServiceDetailsRouterProtocol, service: Service) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.service = service
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupNavBar()
        view?.setupUI()
        view?.setupClinicsCollectionView()
        view?.updateUI(withService: ServiceViewModel(service: service))
    }
    func shareButtonTapped() {
    }
    func backButtonTapped() {
        router?.go(to: .home)
    }
    var numberOfClinics: Int {
        return 10
    }
}
// MARK: - ServiceDetailsOutputInteractorProtocol Implementation
extension ServiceDetailsPresenter: ServiceDetailsOutputInteractorProtocol {
}
