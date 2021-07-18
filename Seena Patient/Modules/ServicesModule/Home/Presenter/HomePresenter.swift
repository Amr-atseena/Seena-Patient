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
    fileprivate var clinic = [Clinic]()
    {
        didSet {
            view?.reloadCategoryTableView()
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
    func viewWillAppear() {
        interactor?.retriveUser()
    }
    func serachButtonTapped(type: Int) {
//        print(specialities[type])
        router?.go(to: .servicesSearch(type != -1 ? specialities[type].id : type))
    }
    func configure(packageCell cell: PackageCellView, atIndex index: Int) {
        let package = packages[index]
        cell.setPackage(PackageViewModel(package: package))
    }
    func configure(spectialityCell cell: SpecialityCellView, atIndex index: Int ) {
        cell.setSpecialityName(specialities[index].speciality ?? "")
        
    }
    func configure(serviceCell cell: ServiceCellProtocol, atIndex index: Int, andSection section: Int) {

        if section == 0 {
            let service = clinic[index]
            cell.setSpeciality(service.name, service.image)
        }else{
            let service = specialities[section].services?[index]
            cell.setService(ServiceViewModel(service: service))
        }

//        let speciality = specialities[index]
//        cell.setSpeciality(speciality.speciality, speciality.image ?? "")
    }

    func configuress(clinicCell cell: ClinicCellProtocol, atIndex index: Int, andSection section: Int) {

        let xxxxx = clinic[section]
        cell.setClinic(ClinicViewModel(clinic: xxxxx))
    }

    func config(ClinicCell cell: ClinicCellProtocol, atIndex index: Int, andSection section: Int) {
        let clinic = specialities[section].clinics?[index]
        cell.setClinic(ClinicViewModel(clinic: clinic))
    }
    func serviceSelected(atIndex index: Int, andSection section: Int) {
        switch section {
        case -1:
            let package = packages[index]
            router?.go(to: .packageDetails(package))
        case -2:
            let speciality = specialities[index]
            router?.go(to: .specialities(speciality))

        case 0:
            let speciality = clinic[index]
//            router?.go(to: .clinic(speciality))
            router?.go(to: .clincss(speciality))
        default:
            guard let service = specialities[section].services?[index] else {return}
            router?.go(to: .serviceDetails(service))
        }
    }


    func numberOfServices(atRow row: Int) -> Int {
        if specialities.isEmpty {
            return 0
        } else {
            return specialities[row].services?.count ?? 0
        }
    }
    var numberOfCategories: Int {
        return specialities.count
    }
    var numberOfPackages: Int {
        return packages.count
    }

//    var numberOfClincs: Int

    var numberOfClincs: Int {
        return clinic.count
    }
}
// MARK: - HomeOutputInteractorProtocol Implementation
extension HomePresenter: HomeOutputInteractorProtocol {
    func onRetriveUserSuccess(withUser user: User?) {
        guard let user = user else {
            view?.setUsername(localization.guest, status: "")
            return
        }
        view?.setUsername(user.firstName, status: user.status ?? "")
    }
    func onRetriveDataSuccess(with homeServices: HomeResponse) {
        view?.hideSkeltonView()
//        specialities = homeServices.specialities
        packages = homeServices.packages
        clinic = homeServices.sponsoredClinics
        UserDefaults.standard.set(homeServices.packages.first?.phone ?? "", forKey: "PackagePhone")
        print(homeServices.packages.first?.phone)

        specialities.removeAll()
        specialities.append(Speciality(id: -1, image: "",speciality: "Clinics".localized,services: [],clinics: homeServices.sponsoredClinics))
        specialities.append(contentsOf: homeServices.specialities)
    }
    func onRetriveDataFail() {
        view?.hideSkeltonView()
    }
}
