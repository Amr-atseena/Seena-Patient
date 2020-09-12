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
}
protocol ATMPayRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: ATMPayRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - ATMPay Interactor
protocol ATMPayInputInteractorProtocol: class {
    var presenter: ATMPayOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol ATMPayOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - ATMPay Preseneter
protocol ATMPayPresenterProtocol: class {
    var view: ATMPayViewProtocol? { get set}
    var interactor: ATMPayInputInteractorProtocol? { get set}
    var router: ATMPayRouterProtocol? { get set }
    var localization: ATMPayLocalization { get }
    // view -> Presenter
    func viewDidLoad()
}
// MARK: - ATMPay View
protocol ATMPayViewProtocol: class {
    var presenter: ATMPayPresenterProtocol! { get set }
    // Presenter -> View
}
