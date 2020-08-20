//
//  HomePresenter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    // MARK: - Attributes
    var router: HomeRouterProtocol?
    var interactor: HomeInputInteractorProtocol?
    weak var view: HomeViewProtocol?
    var localization = HomeLocalization()
    // MARK: - Init
    init(view: HomeViewProtocol, interactor: HomeInputInteractorProtocol, router: HomeRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupNavBar(withTitle: localization.navBarTitle)
        view?.setupUI()
        view?.setupTableView()
    }
    func serachButtonTapped() {
        router?.go(to: .servicesSearch)
    }
    func configure(categoryCell cell: CategoryCellView, atIndex index: Int) {
        cell.setCategoryName("Dental")
    }
    func serviceSelected(atIndex index: Int, andSection section: Int) {
        router?.go(to: .serviceDetails)
    }
    func numberOfServices(atRow row: Int) -> Int {
        return 5
    }
    var numberOfCategories: Int {
      return 3
    }
    var numberOfServicesOfWeak: Int {
        return 4
    }
}
// MARK: - HomeOutputInteractorProtocol Implementation
extension HomePresenter: HomeOutputInteractorProtocol {
}
