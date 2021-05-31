//
//  ATMPayPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit

class ATMPayPresenter: ATMPayPresenterProtocol {
    // MARK: - Attributes
    weak var view: ATMPayViewProtocol?
    var interactor: ATMPayInputInteractorProtocol?
    var router: ATMPayRouterProtocol?
    let localization = ATMPayLocalization()
    let installment: Installment
    var selectAccountIndex = -1
    let type: Int
    private var isNextButtonEnable = false
    private var accounts = [AccountViewModel]() {
        didSet {
            view?.reloadAccounts()
        }
    }
    var numberOfAccounts: Int {
        return accounts.count
    }
    var seenaPayss : Int?
    var seenaMerchant : String?
    var seenaAmount: String?


    // MARK: - Init
    init(view: ATMPayViewProtocol?, interactor: ATMPayInputInteractorProtocol, router: ATMPayRouterProtocol, type: Int, installment: Installment) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.type = type
        self.installment = installment
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setupBankAccountsCollectionView()
        view?.setupSecondPay()
        switch type {
        case 0: print("TYPE IS \(type)")
//        case 0: interactor?.retriveSeena()

        case 1, 2: interactor?.retriveBanksAccount()
        case 3: interactor?.retriveVodafoneAccount()
        case 4: interactor?.retriveEtisalatAccount()
        default: print(type)
        }
    }
    func config(payCell cell: PayOPtionCellProtocol, atIndex index: Int) {
        let account = accounts[index]
        cell.setAccount(account)
    }
    func payOption(selectedAtIndex index: Int) {
        if !isNextButtonEnable {
            view?.enableNextButton()
            isNextButtonEnable = true
        }
        selectAccountIndex = index
    }
    func payOption(deSelectedAtIndex index: Int) {
    }

    var mer: String?
    var am: String?
    func config(payCell cell: PaySeenaProtocol, atIndex index: Int) {
        let accountMer = mer
        let accountAm = am

        cell.setAccount(accountMer!, amount: accountMer!)
    }
    weak var viewController: UIViewController?

    func nextButtonTapped() {
        if seenaPayss == -1 {
            print(UserDefaults.standard.string(forKey: "merchant"))
            print(UserDefaults.standard.string(forKey: "amount"))
            print("Seena pay pressed")

            router?.go(to: .succ)

        }else{
        let account = accounts[selectAccountIndex]
        let payment = Payment(installment: installment, paymentMethod: type, account: account)
        router?.go(to: .pay(payment))
        }
    }
}
// MARK: - ATMPayOutputInteractorProtocol Implementation
extension ATMPayPresenter: ATMPayOutputInteractorProtocol {
    func onRetriveBanksAccountSuccess(_ banksAccounts: [Account]) {
        accounts = banksAccounts.map {
            AccountViewModel(id: $0.id, title: localization.accountsNumbers, accountNumber: $0.number, image: $0.image)
        }
    }
    func onRetriveVodafoneAccountSuccess(_ vodafoneAccounts: [Vodafone]) {
        accounts = vodafoneAccounts.map {
            AccountViewModel(id: $0.id, title: localization.phoneNumbers, accountNumber: $0.number, image: $0.image)
        }
    }

    func onRetriveEtisalatAccountSuccess(_ etisalatAccounts: [Etisalat]) {
        accounts = etisalatAccounts.map {
            AccountViewModel(id: $0.id, title: localization.phoneNumbers, accountNumber: $0.number, image: $0.image)
        }
    }
    func onRetriveSeena() {
        accounts.removeAll()
        accounts.append(AccountViewModel(id: 0, title: "", accountNumber: "", image: ""))
        view?.callCollection()
        seenaPayss = -1
        view?.enableNextButton()

    }
}
