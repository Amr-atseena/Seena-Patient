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
    // MARK: - Init
    init(view: PackageDetailsViewProtocol?, interactor: PackageDetailsInputInteractorProtocol, router: PackageDetailsRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupNavBar()
        view?.setupUI()
        view?.setupServicesCollectionView()
    }
    func shareButtonTapped() {
    }
    func backButtonTapped() {
        router?.go(to: .home)
    }
    var numberOfServices: Int {
        return 10
    }
}
// MARK: - PackageDetailsOutputInteractorProtocol Implementation
extension PackageDetailsPresenter: PackageDetailsOutputInteractorProtocol {
}
