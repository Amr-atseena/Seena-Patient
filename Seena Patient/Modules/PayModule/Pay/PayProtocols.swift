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
}
protocol PayRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: PayRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - Pay Interactor
protocol PayInputInteractorProtocol: class {
    var presenter: PayOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol PayOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - Pay Preseneter
protocol PayPresenterProtocol: class {
    var view: PayViewProtocol? { get set}
    var interactor: PayInputInteractorProtocol? { get set}
    var router: PayRouterProtocol? { get set }
    var localization: PayLocalization { get }
    // view -> Presenter
    func viewDidLoad()
}
// MARK: - Pay View
protocol PayViewProtocol: class {
    var presenter: PayPresenterProtocol! { get set }
    // Presenter -> View
}
