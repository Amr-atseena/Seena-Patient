//
//  ClinicsSearchPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ClinicsSearchPresenter: ClinicsSearchPresenterProtocol {
    // MARK: - Attributes
    weak var view: ClinicsSearchViewProtocol?
    var interactor: ClinicsSearchInputInteractorProtocol?
    var router: ClinicsSearchRouterProtocol?
    let localization = ClinicsSearchLocalization()
    private var cities = [City]() {
        didSet {
            view?.reloadOptions()
        }
    }
    // MARK: - Init
    init(view: ClinicsSearchViewProtocol?, interactor: ClinicsSearchInputInteractorProtocol, router: ClinicsSearchRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setupClinicsTableView()
    }
    func backButtonTapped() {
        router?.go(to: .home)
    }
    func clinicsResultsTableView(selectedAtIndex index: Int) {
        router?.go(to: .clinicDetails)
    }
    func searchButtonTapped(withKeyword keyword: String?) {
        view?.showSkelton()
    }
    var numberOfClinics: Int {
        return 10
    }
}
// MARK: - ClinicsSearchOutputInteractorProtocol Implementation
extension ClinicsSearchPresenter: ClinicsSearchOutputInteractorProtocol {
    func onRetriveCities(_ cities: [City]) {
        self.cities = cities
    }
}
