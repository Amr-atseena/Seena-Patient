//
//  PackageDetailsPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class PackageDetailsPresenter: PackageDetailsPresenterProtocol {
    // MARK: - Attributes
    weak var view: PackageDetailsViewProtocol?
    var interactor: PackageDetailsInputInteractorProtocol?
    var router: PackageDetailsRouterProtocol?
    let localization = PackageDetailsLocalization()
    var package: Package
    var services: [Service] = []
    // MARK: - Init
    init(view: PackageDetailsViewProtocol?, interactor: PackageDetailsInputInteractorProtocol, router: PackageDetailsRouterProtocol, package: Package ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.package = package
        self.services = package.services
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupNavBar()
        view?.setupUI()
        view?.setupServicesCollectionView()
        view?.updateUI(withPackage: PackageViewModel(package: package))
    }
    func shareButtonTapped() {
    }
    func backButtonTapped() {
        router?.go(to: .home)
    }
    func config(serviceCell cell: ServiceCellProtocol, atIndex index: Int) {
        let service = services[index]
        cell.setService(ServiceViewModel(service: service))
    }
    var numberOfServices: Int {
        return services.count
    }
}
// MARK: - PackageDetailsOutputInteractorProtocol Implementation
extension PackageDetailsPresenter: PackageDetailsOutputInteractorProtocol {
}
