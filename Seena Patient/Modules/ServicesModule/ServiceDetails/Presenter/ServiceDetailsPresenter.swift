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
    private var service: Service {
        didSet {
            view?.reloadClinics()
        }
    }
    // MARK: - Init
    init(view: ServiceDetailsViewProtocol,
         interactor: ServiceDetailsInputInteractorProtocol,
         router: ServiceDetailsRouterProtocol,
         service: Service) {
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
        view?.showSkelton()
        interactor?.retriveServiceDetails(atServiceId: service.seriveId)
    }
    func shareButtonTapped() {
    }
    func backButtonTapped() {
        router?.go(to: .home)
    }
    func config(clinicCell cell: ClinicCellProtocol, atIndex index: Int) {
        let clinic = service.clinics?[index]
        cell.setClinic(ClinicViewModel(clinic: clinic))
    }
    func didSelectClinic(atIndex index: Int) {
        guard let clinic = service.clinics?[index] else {return}
        router?.go(to: .clincDetails(clinic: clinic))
    }
    var numberOfClinics: Int {
        return service.clinics?.count ?? 0
    }
}
// MARK: - ServiceDetailsOutputInteractorProtocol Implementation
extension ServiceDetailsPresenter: ServiceDetailsOutputInteractorProtocol {
    func onRetriveDataSuccess(withService service: Service) {
        self.service = service
        view?.hideSkelton()
    }
    func onRetriveDataFail() {
        view?.hideSkelton()
    }
}
