//
//  ServicesSearchProtocols.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/17/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ServicesSearch Router
enum ServicesSearchRoute {
    case home
    case serviceDetails(_ service: Service)
}
protocol ServicesSearchRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: ServicesSearchRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - ServicesSearch Interactor
protocol ServicesSearchInputInteractorProtocol: class {
    var presenter: ServicesSearchOutputInteractorProtocol? { get set }
    var remoteDataServices: ServicesRemoteService? { get set }
    // Presenter -> Interactor
    func fetchServicesList(forKeyword keyword: String, atPage page: Int)
}
protocol ServicesSearchOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveDataSuccess(withServices services: [Service])
    func onRetriveDataFail()
}
// MARK: - ServicesSearch Preseneter
protocol ServicesSearchPresenterProtocol: class {
    var view: ServicesSearchViewProtocol? { get set}
    var interactor: ServicesSearchInputInteractorProtocol? { get set}
    var router: ServicesSearchRouterProtocol? { get set }
    var localization: ServicesSearchLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func fetchServicesList(forKeyword keyword: String?)
    func backButtonTapped()
    func searchButtonTapped(withKeyword keyword: String?)
    func config(servicesSearchCell cell: ServicesSearchCellViewProtocol, atIndex index: Int )
    func servicesCollectionView(selectedAtIndex index: Int)
    var numberOfService: Int { get }
}
// MARK: - ServicesSearch View
protocol ServicesSearchViewProtocol: class {
    var presenter: ServicesSearchPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setupServicesTableView()
    func setupInifityScrolling()
    func reloadServicesTableView()
    func showSkelton()
    func showNoDataView()
    func hideNoDataView()
    func hideSkelton()
}
// MARK: - ServicesSearchCell View
protocol ServicesSearchCellViewProtocol: class {
    func setService(_ service: ServiceViewModel)
}
