//
//  CalculatorProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Calculator Router
enum CalculatorRoute {
    case home
}
protocol CalculatorRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: CalculatorRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - Calculator Interactor
protocol CalculatorInputInteractorProtocol: class {
    var presenter: CalculatorOutputInteractorProtocol? { get set }
    var localDataManager: PaymentLocalDataManagerProtocol { get set }
    // Presenter -> Interactor
    func retrivePlans()
}
protocol CalculatorOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetrivePlansSuccess(_ plans: [Plan])
}
// MARK: - Calculator Preseneter
protocol CalculatorPresenterProtocol: class {
    var view: CalculatorViewProtocol? { get set}
    var interactor: CalculatorInputInteractorProtocol? { get set}
    var router: CalculatorRouterProtocol? { get set }
    var localization: CalculatorLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func backButtonTapped()
    func amountValueChange(_ amount: String?)
    func config(planCell cell: PlanCellProtocol, atIndex index: Int)
    var numberOfPlans: Int { get }
}
// MARK: - Calculator View
protocol CalculatorViewProtocol: class {
    var presenter: CalculatorPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setupPlansTableView()
    func reloadPlans()
}

protocol PlanCellProtocol {
    func setPlan(amount: String, month: String)
}
