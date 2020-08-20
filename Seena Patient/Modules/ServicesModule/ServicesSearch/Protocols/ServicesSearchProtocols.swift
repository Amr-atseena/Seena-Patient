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
    // Presenter -> Interactor
}
protocol ServicesSearchOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - ServicesSearch Preseneter
protocol ServicesSearchPresenterProtocol: class {
    var view: ServicesSearchViewProtocol? { get set}
    var interactor: ServicesSearchInputInteractorProtocol? { get set}
    var router: ServicesSearchRouterProtocol? { get set }
    var localization: ServicesSearchLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func backButtonTapped()
    func searchButtonTapped(withKeyword keyword: String?)
    var numberOfService: Int { get }
}
// MARK: - ServicesSearch View
protocol ServicesSearchViewProtocol: class {
    var presenter: ServicesSearchPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setupServicesTableView()
    func reloadServicesTableView()
    func showSkelton()
    func hideSkelton()
}
