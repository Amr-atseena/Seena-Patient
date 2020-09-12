//
//  SignInProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - SignIn Router
enum SignInRoute {
}
protocol SignInRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: SignInRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - SignIn Interactor
protocol SignInInputInteractorProtocol: class {
    var presenter: SignInOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol SignInOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - SignIn Preseneter
protocol SignInPresenterProtocol: class {
    var view: SignInViewProtocol? { get set}
    var interactor: SignInInputInteractorProtocol? { get set}
    var router: SignInRouterProtocol? { get set }
    var localization: SignInLocalization { get }
    // view -> Presenter
    func viewDidLoad()
}
// MARK: - SignIn View
protocol SignInViewProtocol: class {
    var presenter: SignInPresenterProtocol! { get set }
    // Presenter -> View
}
