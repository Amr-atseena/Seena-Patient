//
//  PaymentChannelPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 07/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class PaymentChannelPresenter: PaymentChannelPresenterProtocol {
    // MARK: - Attributes
    weak var view: PaymentChannelViewProtocol?
    var interactor: PaymentChannelInputInteractorProtocol?
    var router: PaymentChannelRouterProtocol?
    let installment: Installment
    let localization = PaymentChannelLocalization()
    private var paymentMethods = [OptionViewModel]()
    var numberOfPaymentMethods: Int {
        return paymentMethods.count
    }
    // MARK: - Init
    init(view: PaymentChannelViewProtocol?, interactor: PaymentChannelInputInteractorProtocol,
         router: PaymentChannelRouterProtocol, installment: Installment ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.installment = installment
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupNavBar()
        view?.setupUI()
        view?.setupPaymentMethodsTableView()
        paymentMethods = [OptionViewModel(name: localization.seenaPay),
                          OptionViewModel(name: localization.atm),
                          OptionViewModel(name: localization.onlinePay),
                          OptionViewModel(name: localization.vodafoneCash),
                          OptionViewModel(name: localization.etisalatCash)]
    }
    func config(paymentCell cell: PaymentMethodCellProtocol, atIndex index: Int) {
        let option = paymentMethods[index]
        cell.setMethod(option: option)
    }
    func backButtonTapped() {
        router?.go(to: .payHome)
    }
    func option(selectedAtIndex index: Int) {

// كومنت router.go to  .alert ورجع اللي معموله كومنت اللي تحتها اللي جوه ال if index == 0 وبعدين روح على ATMPayPresenter وكومنت case 0 اللي موجوده و uncomment اللي معمولها كومنت

        if index == 0 {
            router?.go(to: .alert(AlertEntity(title: "", message: "SeenaPayMessage".localized)))
//            print ("SS")
//
//            paymentMethods = paymentMethods.map { OptionViewModel(name: $0.name, isSelected: false)}
//            paymentMethods[index].isSelected = true
//            view?.reloadPaymentMethods()
//            router?.go(to: .atm(index, installment))
        }
////            else if index == 4{
////            print("Etisalat")
////        }
        else {
        self.paymentMethods = paymentMethods.map { OptionViewModel(name: $0.name, isSelected: false)}
            paymentMethods[index].isSelected = true
            view?.reloadPaymentMethods()
            router?.go(to: .atm(index, installment))
        }
    }
}
// MARK: - PaymentChannelOutputInteractorProtocol Implementation
extension PaymentChannelPresenter: PaymentChannelOutputInteractorProtocol {
}
