//
//  PayPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class PayPresenter: PayPresenterProtocol {
    // MARK: - Attributes
    weak var view: PayViewProtocol?
    var interactor: PayInputInteractorProtocol?
    var router: PayRouterProtocol?
    let localization = PayLocalization()
    var payment: Payment
    // MARK: - Init
    init(view: PayViewProtocol?, interactor: PayInputInteractorProtocol, router: PayRouterProtocol, payment: Payment ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.payment = payment
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setAccount(image: payment.account.image, accountName: payment.account.title, accountNumber: payment.account.accountNumber)
    }
    func nextButtonTapped(withTransactionId transactionId: String?) {
        guard let transaction = transactionId else {
            return
        }
        payment.tansactionId = transaction
        view?.showLoadingIndicotor()
//        interactor?.payInstallment(payment)
        router?.go(to: .paymentSuccess(payment))


        // call my new api
    }
    func backButtonTapped() {
        router?.go(to: .paymentChannel)
    }
    func transactionIdEditChange(transactionId: String?) {
        guard let transaction = transactionId else {
            return
        }
        if transaction.isEmpty {
            view?.disableNextButton()
        } else {
            view?.enableNextButton()
        }
    }
    func infoButtonTapped() {
        router?.go(to: .info)
    }
}
// MARK: - PayOutputInteractorProtocol Implementation
extension PayPresenter: PayOutputInteractorProtocol {
    func onRetriveDataSuccess() {
        view?.hideLoadingIndictor()
        router?.go(to: .paymentSuccess(payment))
    }
    func onRetriveDataFail(withError error: String) {
        view?.hideLoadingIndictor()
//        router?.go(to: .alert(AlertEntity(title: "Error".localized, message: error)))

        router?.go(to: .paymentSuccess(payment))

    }
}
