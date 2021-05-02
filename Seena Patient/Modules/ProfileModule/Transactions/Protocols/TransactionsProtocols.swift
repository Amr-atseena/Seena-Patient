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
    case back
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
    var remoteDataManager: PaymentRemoteDataManagerProtocol { get set }
    var localDataManager: TokenLocalDataManagerProtocol { get set }
    // Presenter -> Interactor
    func retriveTransactions()
}
protocol TransactionsOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveTransactionsSuccess(withTransactions transactions: [Transaction])
    func onRetriveTransactionsFail()
}
// MARK: - Transactions Preseneter
protocol TransactionsPresenterProtocol: class {
    var view: TransactionsViewProtocol? { get set}
    var interactor: TransactionsInputInteractorProtocol? { get set}
    var router: TransactionsRouterProtocol? { get set }
    var localization: TransactionsLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func backButtonTapped()
    func config(transactionCell cell: TransactionCellProtocol, atIndex index: Int)
    var numberOfTransactions: Int { get }
}
// MARK: - Transactions View
protocol TransactionsViewProtocol: class {
    var presenter: TransactionsPresenterProtocol! { get set }
    // Presenter -> View
    func setupNavBar()
    func setupUI()
    func setupTransactionsTableView()
    func reloadTransactions()
    func showLoadingIndictor()
    func hideLoadingIndictor()
    func showNoDataView()
    func hideNoDataView()
    func showTransactions()
    func hideTransactions()
}

protocol TransactionCellProtocol {
    func setTransaction(_ transaction: TransactionViewModel)
}
