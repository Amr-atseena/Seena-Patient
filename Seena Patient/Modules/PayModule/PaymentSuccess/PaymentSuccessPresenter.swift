//
//  PaymentSuccessPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class PaymentSuccessPresenter: PaymentSuccessPresenterProtocol {
    // MARK: - Attributes
    weak var view: PaymentSuccessViewProtocol?
    var interactor: PaymentSuccessInputInteractorProtocol?
    var router: PaymentSuccessRouterProtocol?
    let localization = PaymentSuccessLocalization()
    let payment: Payment
    // MARK: - Init
    init(view: PaymentSuccessViewProtocol?, interactor: PaymentSuccessInputInteractorProtocol, router: PaymentSuccessRouterProtocol, payment: Payment ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.payment = payment
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        let amount = String(payment.installment.amount) + " " + "EGP".localized
        view?.setAccount(image: payment.account.image, accountName: payment.account.title, accountNumber: payment.account.accountNumber, amount: amount)
    }
    func doneButtonTapped() {
        router?.go(to: .home)
    }
}
// MARK: - PaymentSuccessOutputInteractorProtocol Implementation
extension PaymentSuccessPresenter: PaymentSuccessOutputInteractorProtocol {
}
