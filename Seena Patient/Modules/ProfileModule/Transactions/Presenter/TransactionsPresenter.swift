//
//  TransactionsPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class TransactionsPresenter: TransactionsPresenterProtocol {    
    // MARK: - Attributes
    weak var view: TransactionsViewProtocol?
    var interactor: TransactionsInputInteractorProtocol?
    var router: TransactionsRouterProtocol?
    let localization = TransactionsLocalization()
    var transactions = [Transaction]() {
        didSet {
            if transactions.isEmpty {
                view?.showNoDataView()
                view?.hideTransactions()
            }else {
                view?.hideNoDataView()
                view?.showTransactions()
                view?.reloadTransactions()
            }
        }
    }
    var numberOfTransactions: Int {
        return transactions.count
    }
    // MARK: - Init
    init(view: TransactionsViewProtocol?, interactor: TransactionsInputInteractorProtocol, router: TransactionsRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setupNavBar()
        view?.setupTransactionsTableView()
        view?.hideTransactions()
        view?.hideNoDataView()
        view?.showLoadingIndictor()
        interactor?.retriveTransactions()
    }
    func config(transactionCell cell: TransactionCellProtocol, atIndex index: Int) {
        let transaction = transactions[index]
        cell.setTransaction(TransactionViewModel(transaction: transaction))
    }
    func backButtonTapped() {
        router?.go(to: .back)
    }
}
// MARK: - TransactionsOutputInteractorProtocol Implementation
extension TransactionsPresenter: TransactionsOutputInteractorProtocol {
    func onRetriveTransactionsSuccess(withTransactions transactions: [Transaction]) {
        view?.hideLoadingIndictor()
        self.transactions = transactions
    }
    func onRetriveTransactionsFail() {
        view?.hideLoadingIndictor()
        view?.hideTransactions()
        view?.showNoDataView()
    }
}
