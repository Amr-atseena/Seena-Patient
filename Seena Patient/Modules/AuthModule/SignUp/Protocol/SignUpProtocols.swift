//
//  SignUpProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - SignUp Router
enum SignUpRoute {
}
protocol SignUpRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: SignUpRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - SignUp Interactor
protocol SignUpInputInteractorProtocol: class {
    var presenter: SignUpOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol SignUpOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - SignUp Preseneter
protocol SignUpPresenterProtocol: class {
    var view: SignUpViewProtocol? { get set}
    var interactor: SignUpInputInteractorProtocol? { get set}
    var router: SignUpRouterProtocol? { get set }
    var localization: SignUpLocalization { get }
    // view -> Presenter
    func viewDidLoad()
}
// MARK: - SignUp View
protocol SignUpViewProtocol: class {
    var presenter: SignUpPresenterProtocol! { get set }
    // Presenter -> View
}
