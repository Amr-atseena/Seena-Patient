//
//  SettingsProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Settings Router
enum SettingsRoute {
}
protocol SettingsRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: SettingsRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - Settings Interactor
protocol SettingsInputInteractorProtocol: class {
    var presenter: SettingsOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol SettingsOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - Settings Preseneter
protocol SettingsPresenterProtocol: class {
    var view: SettingsViewProtocol? { get set}
    var interactor: SettingsInputInteractorProtocol? { get set}
    var router: SettingsRouterProtocol? { get set }
    var localization: SettingsLocalization { get }
    // view -> Presenter
    func viewDidLoad()
}
// MARK: - Settings View
protocol SettingsViewProtocol: class {
    var presenter: SettingsPresenterProtocol! { get set }
    // Presenter -> View
}
