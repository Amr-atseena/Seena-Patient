//
//  PaymentSuccessProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - PaymentSuccess Router
enum PaymentSuccessRoute {
    case home
}
protocol PaymentSuccessRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: PaymentSuccessRoute)
    static func assembleModule(withPayment payment: Payment) -> UIViewController
}
// MARK: - PaymentSuccess Interactor
protocol PaymentSuccessInputInteractorProtocol: class {
    var presenter: PaymentSuccessOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol PaymentSuccessOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - PaymentSuccess Preseneter
protocol PaymentSuccessPresenterProtocol: class {
    var view: PaymentSuccessViewProtocol? { get set}
    var interactor: PaymentSuccessInputInteractorProtocol? { get set}
    var router: PaymentSuccessRouterProtocol? { get set }
    var localization: PaymentSuccessLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func doneButtonTapped()
}
// MARK: - PaymentSuccess View
protocol PaymentSuccessViewProtocol: class {
    var presenter: PaymentSuccessPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setAccount(image: String, accountName: String, accountNumber: String, amount: String)
}
