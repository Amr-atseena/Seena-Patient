//
//  PayHomeProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 06/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - PayHome Router
enum PayHomeRoute {
    case paymentChannel(installment: Installment)
    case calculate
    case notActive
}
protocol PayHomeRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: PayHomeRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - PayHome Interactor
protocol PayHomeInputInteractorProtocol: class {
    var presenter: PayHomeOutputInteractorProtocol? { get set }
    var localDataManager: PaymentLocalDataManagerProtocol { get set }
    var remoteDataManager: PaymentRemoteDataManagerProtocol { get set }
    // Presenter -> Interactor
    func retriveUser()
    func retrivePaymentDue(status : String)
}
protocol PayHomeOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveUserSuccess(_ user: User?)
    func onRetrivePaymentSuccess(_ payment: PaymentHomeResponse)
    func onRetrivePaymentFail()
}
// MARK: - PayHome Preseneter
protocol PayHomePresenterProtocol: class {
    var view: PayHomeViewProtocol? { get set}
    var interactor: PayHomeInputInteractorProtocol? { get set}
    var router: PayHomeRouterProtocol? { get set }
    var localization: PayHomeLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func viewWillAppear()
    func payButtonTapped()
    func forStatusUse(status :String)
    func calculateButtonTapped()
    func config(dueCell cell: DueCellProtocol, atIndex index: Int)
    func dueCell(selectedAtIndex index: Int)
    var numberOfDue: Int { get }
}
// MARK: - PayHome View
protocol PayHomeViewProtocol: class {
    var presenter: PayHomePresenterProtocol! { get set }
    // Presenter -> View
    func setupNavBar()
    func setupUI()
    func setupPaymentsDueTableView()
    func realodDue()
    func setPaymentProgress(totalAmount: String, paidAmount: String, avaliableBalance: String, ratio: Double)
    func hideNoDataView()
    func showNoDataView()
    func showPaymentDue()
    func hidePaymentDue()
    func hideLoadingIndictor()
    func showLoadingIndictor()

    func showGetYourSeenaView()
    func hideGetYourSeenaView()
    func showProgressView()
    func hideProgressView()

}

protocol DueCellProtocol {
    func setPaymentDue(_ due: PaymentDueViewModel)
}
