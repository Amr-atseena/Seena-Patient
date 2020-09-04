//
//  ClinicsHomeProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ClinicsHome Router
enum ClinicsHomeRoute {
    case clinicDetails(clinic: Clinic)
    case clincsSearch(speciality: Speciality)
    case call(number: String)
}
protocol ClinicsHomeRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: ClinicsHomeRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - ClinicsHome Interactor
protocol ClinicsHomeInputInteractorProtocol: class {
    var presenter: ClinicsHomeOutputInteractorProtocol? { get set }
    var remoteDataManager: ClinicsRemoteDataManangerProtocol { get set }
    // Presenter -> Interactor
    func retriveClinicsHome()
}
protocol ClinicsHomeOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveClinicsHomeSuccess(specialities: [Speciality], clinicOfTheWeek: Clinic)
    func onRetriveClincsHomeFail()
}
// MARK: - ClinicsHome Preseneter
protocol ClinicsHomePresenterProtocol: class {
    var view: ClinicsHomeViewProtocol? { get set}
    var interactor: ClinicsHomeInputInteractorProtocol? { get set}
    var router: ClinicsHomeRouterProtocol? { get set }
    var localization: ClinicsHomeLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func retiveClinicHome()
    func searchButtonTapped()
    func clinicOfWeekButtonTapped()
    func callButtonTapped()
    func config(ClinicCell cell: ClinicCellProtocol, atIndex index: Int, andSection section: Int)
    func config(headerCell cell: ClinicsSectionHeaderCellProtocol, atSection section: Int)
    func clinicTableView(selectedAtIndex index: Int, andSection section: Int)
    func callButtonTapped(atSection section: Int, andIndex index: Int)
    func seeAllButtonTapped(atSection section: Int)
    func numberOfClincs(inSection section: Int) -> Int
    var numberOfSections: Int { get }
}
// MARK: - ClinicsHome View
protocol ClinicsHomeViewProtocol: class {
    var presenter: ClinicsHomePresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setupNavBar(withTitle title: String)
    func setupClinicsTableView()
    func setClinicOfTheWeek(_ clinic: ClinicViewModel)
    func reloadClinics()
    func showSkeleton()
    func hideSkeleton()
}
protocol ClinicsSectionHeaderCellProtocol {
    func setSpeciality(name: String)
}
