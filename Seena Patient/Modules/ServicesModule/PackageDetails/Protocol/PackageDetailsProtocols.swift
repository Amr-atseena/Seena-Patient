//
//  PackageDetailsProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - PackageDetails Router
enum PackageDetailsRoute {
    case serviceDetails
    case home
}
protocol PackageDetailsRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: PackageDetailsRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - PackageDetails Interactor
protocol PackageDetailsInputInteractorProtocol: class {
    var presenter: PackageDetailsOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol PackageDetailsOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - PackageDetails Preseneter
protocol PackageDetailsPresenterProtocol: class {
    var view: PackageDetailsViewProtocol? { get set}
    var interactor: PackageDetailsInputInteractorProtocol? { get set}
    var router: PackageDetailsRouterProtocol? { get set }
    var localization: PackageDetailsLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func shareButtonTapped()
    func backButtonTapped()
    var numberOfServices: Int { get }
}
// MARK: - PackageDetails View
protocol PackageDetailsViewProtocol: class {
    var presenter: PackageDetailsPresenterProtocol! { get set }
    // Presenter -> View
    func setupNavBar()
    func setupUI()
    func setupServicesCollectionView()
}
