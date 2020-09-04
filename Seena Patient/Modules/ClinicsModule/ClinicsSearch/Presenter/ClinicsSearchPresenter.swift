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
    private var page = 0
    private var speciality: Speciality
    private var searchKeyword = ""
    private var clinics = [Clinic]()
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
    init(view: ClinicsSearchViewProtocol?, interactor: ClinicsSearchInputInteractorProtocol, router: ClinicsSearchRouterProtocol, speciality: Speciality) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.speciality = speciality
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setSpeciality(name: speciality.speciality)
        view?.setupClinicsTableView()
        view?.setupInfintyScrolling()
        view?.setupOptionsCollectionView(withOptionsAdapter: optionsAdapter)
        interactor?.retriveCities()
        retriveClinicsList()
    }
    func retriveClinicsList() {
        if clinics.isEmpty {
            view?.showSkelton()
        }
        let cityId = cities[selectedCityIndex].id
        let parms = ClinicsListParameters(specialityId: speciality.id, cityId: cityId, searchKeyword: searchKeyword, currentPage: page)
        interactor?.retriveClinicsList(withParameters: parms)
    }
    func backButtonTapped() {
        router?.go(to: .home)
    }
    func clinicsResultsTableView(selectedAtIndex index: Int) {
        let clinic = clinics[index]
        router?.go(to: .clinicDetails(clinic: clinic))
    }
    func searchButtonTapped(withKeyword keyword: String?) {
        view?.showSkelton()
        page = 0
        searchKeyword = keyword ?? ""
        clinics.removeAll()
        retriveClinicsList()
    }
    func config(ClinicCell cell: ClinicCellProtocol, atIndex index: Int) {
        let clinic = clinics[index]
        cell.setClinic(ClinicViewModel(clinic: clinic))
    }
    func callButtonTapped(atIndex index: Int) {
        let clinicNumber  = clinics[index].phone
        router?.go(to: .call(number: clinicNumber))
    }
    var numberOfClinics: Int {
        return clinics.count
    }
}
// MARK: - ClinicsSearchOutputInteractorProtocol Implementation
extension ClinicsSearchPresenter: ClinicsSearchOutputInteractorProtocol {
    func onRetriveCities(_ cities: [City]) {
        self.cities = cities
        if !options.isEmpty {
            options[0].isSelected = true
        }
    }
    func onRetriveClinicsListSuccess(_ clinics: [Clinic]) {
        view?.hideSkelton()
        self.clinics.append(contentsOf: clinics)
        if self.clinics.isEmpty {
            view?.showNoDataView()
        } else {
            view?.hideNoDataView()
            page += 1
        }
        view?.reloadClinicsTableView()
    }
    func onRetriveClinicsListFail() {
        view?.hideSkelton()
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
        page = 0
        clinics.removeAll()
        retriveClinicsList()
    }
    var numberOfOptions: Int {
        return cities.count
    }
}
