//
//  ATMPayProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ATMPay Router
enum ATMPayRoute {
    case pay(Payment)
    case succ
}
protocol ATMPayRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: ATMPayRoute)
    static func assembleModule(withType type: Int, andInstallment installment: Installment) -> UIViewController
}
// MARK: - ATMPay Interactor
protocol ATMPayInputInteractorProtocol: class {
    var presenter: ATMPayOutputInteractorProtocol? { get set }
    var localDataManager: PaymentLocalDataManagerProtocol { get set }
    // Presenter -> Interactor
    func retriveBanksAccount()
    func retriveVodafoneAccount()
    func retriveEtisalatAccount()
//    func retriveOrangeAccount()
    func retriveSeena()

}
protocol ATMPayOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveBanksAccountSuccess(_ banksAccounts: [Account])
    func onRetriveVodafoneAccountSuccess(_ vodafoneAccounts: [Vodafone])
    func onRetriveEtisalatAccountSuccess(_ etisalatAccounts: [Etisalat])
//    func onRetriveOrangeAccountSuccess(_ orangeAccounts: [Orange])
    func onRetriveSeena()

}
// MARK: - ATMPay Preseneter
protocol ATMPayPresenterProtocol: class {
    var view: ATMPayViewProtocol? { get set}
    var interactor: ATMPayInputInteractorProtocol? { get set}
    var router: ATMPayRouterProtocol? { get set }
    var localization: ATMPayLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func config(payCell cell: PayOPtionCellProtocol, atIndex index: Int)
    func payOption(selectedAtIndex index: Int)
    func payOption(deSelectedAtIndex index: Int)
    func nextButtonTapped()
    var numberOfAccounts: Int { get }
}
// MARK: - ATMPay View
protocol ATMPayViewProtocol: class {
    var presenter: ATMPayPresenterProtocol! { get set }
    // Presenter -> View
    func setupBankAccountsCollectionView()
    func setupSecondPay()
    func setupUI()
    func enableNextButton()
    func reloadAccounts()
    func callCollection()
}
// MARK: - PayOPtionCellProtocol
protocol PayOPtionCellProtocol: class {
    func setAccount(_ account: AccountViewModel)
}


// MARK: - PayOPtionCellProtocol
protocol PaySeenaProtocol: class {
    func setAccount(_ merchant: String, amount : String)
}
