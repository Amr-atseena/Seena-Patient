//
//  HomeProtocols.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Home Router
enum HomeRoute {
    case serviceDetails(_ service: Service)
    case packageDetails(_ package: Package)
    case serviceList
    case servicesSearch
}
protocol HomeRouterProtocol: class {
    var viewController: UIViewController? { get set }
    func go(to router: HomeRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - Home Interactor
protocol HomeInputInteractorProtocol: class {
    var presenter: HomeOutputInteractorProtocol? { get set }
    var remoteDataServices: ServicesRemoteDataManager? { get set }
    // Presenter -> Interactor
    func fetchHomeServices()
}
protocol HomeOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveDataSuccess(with homeServices: HomeResponse)
    func onRetriveDataFail()
}
// MARK: - Home Presenter
protocol HomePresenterProtocol: class {
    var router: HomeRouterProtocol? { get set }
    var interactor: HomeInputInteractorProtocol? { get set }
    var view: HomeViewProtocol? { get set }
    var localization: HomeLocalization { get set }
    // View -> Presenter
    func viewDidLoad()
    func serachButtonTapped()
    func configure(spectialityCell cell: SpecialityCellView, atIndex index: Int )
    func configure(packageCell cell: PackageCellView, atIndex index: Int )
    func configure(serviceCell cell: ServiceCellView, atIndex index: Int, andSection section: Int)
    func serviceSelected(atIndex index: Int, andSection section: Int)
    func numberOfServices(atRow row: Int) -> Int
    var numberOfCategories: Int { get }
    var numberOfPackages: Int { get }
}
// MARK: - Home View
protocol HomeViewProtocol: class {
    var presenter: HomePresenterProtocol! { get set }
    // Presenter -> View
    func setupNavBar(withTitle title: String)
    func setupUI()
    func setupTableView()
    func reloadPackageCollectionView()
    func reloadCategoryTableView()
    func showSkeltonView()
    func hideSkeltonView()
}
// MARK: - SpecialityCell  View
protocol SpecialityCellView {
    func setSpecialityName(_ specialityName: String)
}
// MARK: - Package Cell View
protocol PackageCellView {
    func setPackage(_ package: PackageViewModel)
}
// MARK: - Service Cell View
protocol ServiceCellView {
    func setService(_ service: ServiceViewModel)
}
