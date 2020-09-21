//
//  TransactionsProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Transactions Router
enum TransactionsRoute {
}
protocol TransactionsRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: TransactionsRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - Transactions Interactor
protocol TransactionsInputInteractorProtocol: class {
    var presenter: TransactionsOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol TransactionsOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - Transactions Preseneter
protocol TransactionsPresenterProtocol: class {
    var view: TransactionsViewProtocol? { get set}
    var interactor: TransactionsInputInteractorProtocol? { get set}
    var router: TransactionsRouterProtocol? { get set }
    var localization: TransactionsLocalization { get }
    // view -> Presenter
    func viewDidLoad()
}
// MARK: - Transactions View
protocol TransactionsViewProtocol: class {
    var presenter: TransactionsPresenterProtocol! { get set }
    // Presenter -> View
}
