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
    }
    func searchButtonTapped() {
        let speciality = Speciality(id: 0, image: "", speciality: "", services: [], clinics: [])
        router?.go(to: .clincsSearch(speciality: speciality))
    }
    func clinicOfWeekButtonTapped() {
        router?.go(to: .clinicDetails)
    }
    func callButtonTapped() {
      //  router?.go(to: .clincsSearch)
    }
    func clinicTableView(selectedAtIndex index: Int, andSection section: Int) {
        router?.go(to: .clinicDetails)
    }
    func numberOfClincs(inSection section: Int) -> Int {
        return 3
    }
    var numberOfSections: Int {
        return 3
    }
}
// MARK: - ClinicsHomeOutputInteractorProtocol Implementation
extension ClinicsHomePresenter: ClinicsHomeOutputInteractorProtocol {
    func onRetriveClinicsHomeSuccess(specialities: [Speciality], clinicOfTheWeek: Clinic) {
    
    }
    func onRetriveClincsHomeFail() {
    }
    
}
