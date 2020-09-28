//
//  ClinicsSearchProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ClinicsSearch Router
enum ClinicsSearchRoute {
    case home
    case clinicDetails(clinic: Clinic)
    case call(number: String)
}
protocol ClinicsSearchRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: ClinicsSearchRoute)
    static func assembleModule(withSpeciality speciality: Speciality) -> UIViewController
}
// MARK: - ClinicsSearch Interactor
protocol ClinicsSearchInputInteractorProtocol: class {
    var presenter: ClinicsSearchOutputInteractorProtocol? { get set }
    var localDataManager: ClinicsSearchLocalDataManagerProtocol { get set }
    var remoteDataManager: ClinicsRemoteDataManangerProtocol { get set }
    // Presenter -> Interactor
    func retriveCities()
    func retriveClinicsList(withParameters parms: ClinicsListParameters)
}
protocol ClinicsSearchOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveCities(_ cities: [City])
    func onRetriveClinicsListSuccess(_ clinics: [Clinic])
    func onRetriveClinicsListFail()
}
// MARK: - ClinicsSearch Preseneter
protocol ClinicsSearchPresenterProtocol: class {
    var view: ClinicsSearchViewProtocol? { get set}
    var interactor: ClinicsSearchInputInteractorProtocol? { get set}
    var router: ClinicsSearchRouterProtocol? { get set }
    var localization: ClinicsSearchLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func retriveClinicsList()
    func backButtonTapped()
    func searchButtonTapped(withKeyword keyword: String?)
    func callButtonTapped(atIndex index: Int)
    func clinicsResultsTableView(selectedAtIndex index: Int)
    func config(ClinicCell cell: ClinicCellProtocol, atIndex index: Int)
    var numberOfClinics: Int { get }
}
// MARK: - ClinicsSearch View
protocol ClinicsSearchViewProtocol: class {
    var presenter: ClinicsSearchPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setupInfintyScrolling()
    func setSpeciality(name: String)
    func setupClinicsTableView()
    func setupOptionsCollectionView(withOptionsAdapter optionsAdapter: OptionsAdapter)
    func reloadOptions()
    func reloadClinicsTableView()
    func showSkelton()
    func hideSkelton()
    func showNoDataView()
    func hideNoDataView()
}
// MARK: - OptionsAdapter
protocol OptionsAdapterProtocol: class {
    func cnofig(optionCell cell: OptionCellProtocol, atIndex index: Int)
    func optionCell(selectedAtIndex index: Int)
    func optionCell(deSelectedAtIndex index: Int)
    var numberOfOptions: Int { get }
}
// MARK: - OptionCell Protocol
protocol OptionCellProtocol {
    func set(option: OptionViewModel)
}
