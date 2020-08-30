//
//  ProfileProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 29/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Profile Router
enum ProfileRoute {
}
protocol ProfileRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: ProfileRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - Profile Interactor
protocol ProfileInputInteractorProtocol: class {
    var presenter: ProfileOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol ProfileOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - Profile Preseneter
protocol ProfilePresenterProtocol: class {
    var view: ProfileViewProtocol? { get set}
    var interactor: ProfileInputInteractorProtocol? { get set}
    var router: ProfileRouterProtocol? { get set }
    var localization: ProfileLocalization { get }
    // view -> Presenter
    func viewDidLoad()
}
// MARK: - Profile View
protocol ProfileViewProtocol: class {
    var presenter: ProfilePresenterProtocol! { get set }
    // Presenter -> View
}
