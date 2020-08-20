//
//  ServicesSearchPresenter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/17/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ServicesSearchPresenter: ServicesSearchPresenterProtocol {
    // MARK: - Attributes
    weak var view: ServicesSearchViewProtocol?
    var interactor: ServicesSearchInputInteractorProtocol?
    var router: ServicesSearchRouterProtocol?
    let localization = ServicesSearchLocalization()
    // MARK: - Init
    init(view: ServicesSearchViewProtocol?, interactor: ServicesSearchInputInteractorProtocol, router: ServicesSearchRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setupServicesTableView()
    }
    func backButtonTapped() {
        router?.go(to: .home)
    }
    func searchButtonTapped(withKeyword keyword: String?) {
        view?.showSkelton()
    }
    var numberOfService: Int {
        return 10
    }
}
// MARK: - ServicesSearchOutputInteractorProtocol Implementation
extension ServicesSearchPresenter: ServicesSearchOutputInteractorProtocol {
}
