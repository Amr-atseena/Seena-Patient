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
    }
    func backButtonTapped() {
        router?.go(to: .back)
    }
}
// MARK: - TransactionsOutputInteractorProtocol Implementation
extension TransactionsPresenter: TransactionsOutputInteractorProtocol {
}
