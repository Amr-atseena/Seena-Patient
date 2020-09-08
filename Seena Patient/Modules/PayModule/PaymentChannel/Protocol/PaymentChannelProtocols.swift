//
//  PaymentChannelProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 07/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - PaymentChannel Router
enum PaymentChannelRoute {
}
protocol PaymentChannelRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: PaymentChannelRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - PaymentChannel Interactor
protocol PaymentChannelInputInteractorProtocol: class {
    var presenter: PaymentChannelOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol PaymentChannelOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - PaymentChannel Preseneter
protocol PaymentChannelPresenterProtocol: class {
    var view: PaymentChannelViewProtocol? { get set}
    var interactor: PaymentChannelInputInteractorProtocol? { get set}
    var router: PaymentChannelRouterProtocol? { get set }
    var localization: PaymentChannelLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func config(paymentCell cell: PaymentMethodCellProtocol, atIndex index: Int)
    func option(selectedAtIndex index: Int)
    var numberOfPaymentMethods: Int { get }
}
// MARK: - PaymentChannel View
protocol PaymentChannelViewProtocol: class {
    var presenter: PaymentChannelPresenterProtocol! { get set }
    // Presenter -> View
    func setupNavBar()
    func setupUI()
    func setupPaymentMethodsTableView()
    func reloadPaymentMethods()
}
// MARK: - PaymentChannel View
protocol PaymentMethodCellProtocol: class {
    func setMethod(option: OptionViewModel)
}
