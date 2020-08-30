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
    fileprivate var specialities = [Speciality]() {
        didSet {
            view?.reloadCategoryTableView()
        }
    }
    fileprivate var packages = [Package]() {
        didSet {
            view?.reloadPackageCollectionView()
        }
    }
    // MARK: - Init
    init(view: HomeViewProtocol, interactor: HomeInputInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupNavBar(withTitle: localization.navBarTitle)
        view?.setupUI()
        view?.setupTableView()
        view?.showSkeltonView()
        interactor?.fetchHomeServices()
    }
    func serachButtonTapped() {
        router?.go(to: .servicesSearch)
    }
    func configure(packageCell cell: PackageCellView, atIndex index: Int) {
        let package = packages[index]
        cell.setPackage(PackageViewModel(package: package))
    }
    func configure(spectialityCell cell: SpecialityCellView, atIndex index: Int) {
        cell.setSpecialityName(specialities[index].speciality)
    }
    func configure(serviceCell cell: ServiceCellView, atIndex index: Int, andSection section: Int) {
        let service = specialities[section].services[index]
        cell.setService(ServiceViewModel(service: service))
    }
    func serviceSelected(atIndex index: Int, andSection section: Int) {
        switch section {
        case -1:
            let package = packages[index]
            router?.go(to: .packageDetails(package))
        default:
            let service = specialities[section].services[index]
            router?.go(to: .serviceDetails(service))
        }
    }
    func numberOfServices(atRow row: Int) -> Int {
        if specialities.isEmpty {
            return 0
        } else {
            return specialities[row].services.count
        }
    }
    var numberOfCategories: Int {
        return specialities.count
    }
    var numberOfPackages: Int {
        return packages.count
    }
}
// MARK: - HomeOutputInteractorProtocol Implementation
extension HomePresenter: HomeOutputInteractorProtocol {
    func onRetriveDataSuccess(with homeServices: HomeResponse) {
        view?.hideSkeltonView()
        specialities = homeServices.specialities
        packages = homeServices.packages
    }
    func onRetriveDataFail() {
        view?.hideSkeltonView()
    }
}
