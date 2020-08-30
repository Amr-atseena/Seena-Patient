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
    var keyword = ""
    var page = 0
    var services = [Service]()
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
        view?.setupInifityScrolling()
        fetchServicesList(forKeyword: keyword)
    }
    func fetchServicesList(forKeyword keyword: String?) {
        if services.isEmpty {
            view?.showSkelton()
        }
        interactor?.fetchServicesList(forKeyword: keyword ?? "", atPage: page)
    }
    func backButtonTapped() {
        router?.go(to: .home)
    }
    func searchButtonTapped(withKeyword keyword: String?) {
        view?.showSkelton()
        services.removeAll()
        page = 0
        self.keyword = keyword ?? ""
        fetchServicesList(forKeyword: keyword)
    }
    func config(servicesSearchCell cell: ServicesSearchCellViewProtocol, atIndex index: Int) {
        let service = services[index]
        cell.setService(ServiceViewModel(service: service))
    }
    func servicesCollectionView(selectedAtIndex index: Int) {
        let service = services[index]
        router?.go(to: .serviceDetails(service))
    }
    var numberOfService: Int {
        return services.count
    }
}
// MARK: - ServicesSearchOutputInteractorProtocol Implementation
extension ServicesSearchPresenter: ServicesSearchOutputInteractorProtocol {
    func onRetriveDataSuccess(withServices services: [Service]) {
        view?.hideSkelton()
        self.services.append(contentsOf: services)
        if self.services.isEmpty {
            view?.showNoDataView()
        } else {
            view?.hideNoDataView()
            page += 1
        }
        view?.reloadServicesTableView()
    }
    func onRetriveDataFail() {
        view?.hideSkelton()
    }
}
