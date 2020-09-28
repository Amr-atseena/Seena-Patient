//
//  ClinicsHomePresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ClinicsHomePresenter: ClinicsHomePresenterProtocol {
    // MARK: - Attributes
    weak var view: ClinicsHomeViewProtocol?
    var interactor: ClinicsHomeInputInteractorProtocol?
    var router: ClinicsHomeRouterProtocol?
    let localization = ClinicsHomeLocalization()
    private var specialities = [Speciality]() {
        didSet {
            view?.reloadClinics()
        }
    }
    private var clinicOfTheWeek: Clinic!
    // MARK: - Init
    init(view: ClinicsHomeViewProtocol?, interactor: ClinicsHomeInputInteractorProtocol, router: ClinicsHomeRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setupNavBar(withTitle: "")
        view?.setupClinicsTableView()
        retiveClinicHome()
    }
    func retiveClinicHome() {
        view?.showSkeleton()
        interactor?.retriveClinicsHome()
    }
    func searchButtonTapped() {
        let speciality = Speciality(id: 0, speciality: "", services: [], clinics: [])
        router?.go(to: .clincsSearch(speciality: speciality))
    }
    func clinicOfWeekButtonTapped() {
        router?.go(to: .clinicDetails(clinic: clinicOfTheWeek))
    }
    func callButtonTapped() {
        router?.go(to: .call(number: clinicOfTheWeek.phone))
    }
    func config(headerCell cell: ClinicsSectionHeaderCellProtocol, atSection section: Int) {
        if !specialities.isEmpty {
            cell.setSpeciality(name: specialities[section].speciality)
        }
    }
    func config(ClinicCell cell: ClinicCellProtocol, atIndex index: Int, andSection section: Int) {
        let clinic = specialities[section].clinics?[index]
        cell.setClinic(ClinicViewModel(clinic: clinic))
    }
    func clinicTableView(selectedAtIndex index: Int, andSection section: Int) {
        guard let clinic = specialities[section].clinics?[index] else { return }
        router?.go(to: .clinicDetails(clinic: clinic))
    }
    func callButtonTapped(atSection section: Int, andIndex index: Int) {
        guard let clinic = specialities[section].clinics?[index] else { return }
        router?.go(to: .call(number: clinic.phone))
    }
    func seeAllButtonTapped(atSection section: Int) {
        router?.go(to: .clincsSearch(speciality: specialities[section]))
    }
    func numberOfClincs(inSection section: Int) -> Int {
        return specialities[section].clinics?.count ?? 0
    }
    var numberOfSections: Int {
        return specialities.count
    }
}
// MARK: - ClinicsHomeOutputInteractorProtocol Implementation
extension ClinicsHomePresenter: ClinicsHomeOutputInteractorProtocol {
    func onRetriveClinicsHomeSuccess(specialities: [Speciality], clinicOfTheWeek: Clinic?) {
        view?.hideSkeleton()
        self.specialities = specialities
        self.clinicOfTheWeek = clinicOfTheWeek
        guard let clinic = clinicOfTheWeek else {
            view?.hideClinicOfTheWeek()
            return
        }
        view?.showClinicOfThWeek()
        view?.setClinicOfTheWeek(ClinicViewModel(clinic: clinic))
    }
    func onRetriveClincsHomeFail() {
        view?.hideSkeleton()
    }
}
