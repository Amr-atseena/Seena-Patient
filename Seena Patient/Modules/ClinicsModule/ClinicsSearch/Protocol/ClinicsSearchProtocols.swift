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
    case clinicDetails
}
protocol ClinicsSearchRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: ClinicsSearchRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - ClinicsSearch Interactor
protocol ClinicsSearchInputInteractorProtocol: class {
    var presenter: ClinicsSearchOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol ClinicsSearchOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - ClinicsSearch Preseneter
protocol ClinicsSearchPresenterProtocol: class {
    var view: ClinicsSearchViewProtocol? { get set}
    var interactor: ClinicsSearchInputInteractorProtocol? { get set}
    var router: ClinicsSearchRouterProtocol? { get set }
    var localization: ClinicsSearchLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func backButtonTapped()
    func searchButtonTapped(withKeyword keyword: String?)
    func clinicsResultsTableView(selectedAtIndex index: Int)
    var numberOfClinics: Int { get }
}
// MARK: - ClinicsSearch View
protocol ClinicsSearchViewProtocol: class {
    var presenter: ClinicsSearchPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setupClinicsTableView()
    func setupOptionsCollectionView(withOptionsAdapter optionsAdapter: OptionsAdapter)
    func reloadOptions()
    func reloadClinicsTableView()
    func showSkelton()
    func hideSkelton()
}
// MARK: - OptionsAdapter
protocol OptionsAdapterProtocol: class {
    func cnofig(optionCell cell: OptionCellProtocol, atIndex index: Int)
    func optionCell(selectedAtIndex index: Int)
    var numberOfOptions: Int { get }
}
// MARK: - OptionCell Protocol
protocol OptionCellProtocol {
    func set(option: OptionViewModel)
}
