//
//  PayProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Pay Router
enum PayRoute {
    case paymentChannel
    case alert(AlertEntity)
    case paymentSuccess(Payment)
    case info
}
protocol PayRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: PayRoute)
    static func assembleModule(withPayment payment: Payment) -> UIViewController
}
// MARK: - Pay Interactor
protocol PayInputInteractorProtocol: class {
    var presenter: PayOutputInteractorProtocol? { get set }
    var localDataManager: PaymentLocalDataManagerProtocol { get set }
    var remoteDataManager: PaymentRemoteDataManagerProtocol { get set}
    // Presenter -> Interactor
    func payInstallment(_ payemnt: Payment)
}
protocol PayOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveDataSuccess()
    func onRetriveDataFail(withError error: String)
}
// MARK: - Pay Preseneter
protocol PayPresenterProtocol: class {
    var view: PayViewProtocol? { get set}
    var interactor: PayInputInteractorProtocol? { get set}
    var router: PayRouterProtocol? { get set }
    var localization: PayLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func backButtonTapped()
    func nextButtonTapped(withTransactionId transactionId: String?)
    func transactionIdEditChange(transactionId: String?)
    func infoButtonTapped()
}
// MARK: - Pay View
protocol PayViewProtocol: class {
    var presenter: PayPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setAccount(image: String, accountName: String, accountNumber: String)
    func enableNextButton()
    func disableNextButton()
    func showLoadingIndicotor()
    func hideLoadingIndictor()
}
