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
    private var selectedCityIndex = 0
    private lazy var optionsAdapter: OptionsAdapter = {
        return OptionsAdapter(presenter: self)
        }()
    private var options = [OptionViewModel]() {
        didSet {
            view?.reloadOptions()
        }
    }
    private var cities = [City]() {
        didSet {
            cities.insert(City(id: 0, name: "All"), at: 0)
            options = cities.map { OptionViewModel(name: $0.name) }
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
        view?.setupOptionsCollectionView(withOptionsAdapter: optionsAdapter)
        interactor?.retriveCities()
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
        options[0].isSelected = true
    }
}
// MARK: - OptionAdapterProtocol Impelementation
extension ClinicsSearchPresenter: OptionsAdapterProtocol {
    func cnofig(optionCell cell: OptionCellProtocol, atIndex index: Int) {
        cell.set(option: options[index])
    }
    func optionCell(selectedAtIndex index: Int) {
        selectedCityIndex = index
        options = options.map {OptionViewModel(name: $0.name)}
        options[index].isSelected = true
    }
    var numberOfOptions: Int {
        return cities.count
    }
}
