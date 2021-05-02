//
//  PayHomePresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 06/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class PayHomePresenter: PayHomePresenterProtocol {
    // MARK: - Attributes
    weak var view: PayHomeViewProtocol?
    var interactor: PayHomeInputInteractorProtocol?
    var router: PayHomeRouterProtocol?
    let localization = PayHomeLocalization()
    var payment: PaymentHomeResponse?
    var numberOfDue: Int {
        return payment?.installment.count ?? 0
    }
    // MARK: - Init
    init(view: PayHomeViewProtocol?, interactor: PayHomeInputInteractorProtocol, router: PayHomeRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupNavBar()
        view?.setupUI()
        view?.setupPaymentsDueTableView()
    }
    func viewWillAppear() {
        interactor?.retriveUser()
    }
    func payButtonTapped() {
       // router?.go(to: .paymentChannel)
    }
    func calculateButtonTapped() {
        router?.go(to: .calculate)
    }
    func config(dueCell cell: DueCellProtocol, atIndex index: Int) {
        guard let installment = payment?.installment[index] else {
            return
        }
        let due = PaymentDueViewModel(installment: installment)
        cell.setPaymentDue(due)
    }
    func dueCell(selectedAtIndex index: Int) {
        guard let installment = payment?.installment[index] else { return }
        router?.go(to: .paymentChannel(installment: installment))
    }
}
// MARK: - PayHomeOutputInteractorProtocol Implementation
extension PayHomePresenter: PayHomeOutputInteractorProtocol {
    func onRetriveUserSuccess(_ user: User?) {
        guard let _ = user else {
            view?.showNoDataView()
            view?.hidePaymentDue()
            view?.showGetYourSeenaView()
            view?.hideProgressView()
            view?.setPaymentProgress(totalAmount: "no Due Payement".localized, paidAmount: "", avaliableBalance: "", ratio: 0)
            return
        }
        view?.hideGetYourSeenaView()
        view?.showProgressView()
        view?.hideNoDataView()
        view?.hidePaymentDue()
        view?.showLoadingIndictor()
        interactor?.retrivePaymentDue()
    }
    func onRetrivePaymentSuccess(_ payment: PaymentHomeResponse) {
        view?.hideLoadingIndictor()
        self.payment = payment
        if payment.installment.isEmpty {
            view?.showNoDataView()
            view?.hidePaymentDue()
            let avaliable = String(payment.walletCredit) + " " + "EGP".localized
            view?.setPaymentProgress(totalAmount: "no Due Payement".localized, paidAmount: "", avaliableBalance: avaliable, ratio: 0)
        } else {
            view?.hideNoDataView()
            view?.showPaymentDue()
            view?.realodDue()
            let paid = "\(payment.paidCredit)" + " " + "EGP".localized
            let total = "of".localized + " " + "\(payment.dueCredit + payment.paidCredit)" + " " + "EGP".localized
            let ratio = Double(payment.paidCredit ) / Double(payment.dueCredit + payment.paidCredit)
            let avaliable = String(payment.walletCredit) + " " + "EGP".localized
            view?.setPaymentProgress(totalAmount: total, paidAmount: paid, avaliableBalance: avaliable, ratio: Double(ratio))
        }
    }
    func onRetrivePaymentFail() {
        view?.hideLoadingIndictor()
    }
}
