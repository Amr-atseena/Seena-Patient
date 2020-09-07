//
//  PayHomeProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 06/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - PayHome Router
enum PayHomeRoute {
}
protocol PayHomeRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: PayHomeRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - PayHome Interactor
protocol PayHomeInputInteractorProtocol: class {
    var presenter: PayHomeOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol PayHomeOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - PayHome Preseneter
protocol PayHomePresenterProtocol: class {
    var view: PayHomeViewProtocol? { get set}
    var interactor: PayHomeInputInteractorProtocol? { get set}
    var router: PayHomeRouterProtocol? { get set }
    var localization: PayHomeLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func payButtonTapped()
    func calculateButtonTapped()
    var numberOfDue: Int { get }
}
// MARK: - PayHome View
protocol PayHomeViewProtocol: class {
    var presenter: PayHomePresenterProtocol! { get set }
    // Presenter -> View
    func setupNavBar()
    func setupUI()
    func setupPaymentsDueTableView()
    func realodDue()
}
