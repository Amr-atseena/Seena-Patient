//
//  SplashProtocols.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Splash Router
enum SplashRoute {
    case tabBar
}
protocol SplashRouterProtocol: class {
    var viewController: UIViewController? { get set }
    func go(to router: SplashRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - Splash Interactor
protocol SplashInputInteractorProtocol: class {
    var presenter: SplashOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol SplashOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - Splash Presenter
protocol SplashPresenterProtocol: class {
    var router: SplashRouterProtocol? { get set }
    var interactor: SplashInputInteractorProtocol? { get set }
    var view: SplashViewProtocol? { get set }
    // View -> Presenter
    func viewDidLoad()
}
// MARK: - Splash View
protocol SplashViewProtocol: class {
    var presenter: SplashPresenterProtocol! { get set }
    // Presenter -> View
    func showLoadingIndictor()
    func hideLoadingIndictor()
}