//
//  NotificationsHomeProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - NotificationsHome Router
enum NotificationsHomeRoute {
}
protocol NotificationsHomeRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: NotificationsHomeRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - NotificationsHome Interactor
protocol NotificationsHomeInputInteractorProtocol: class {
    var presenter: NotificationsHomeOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol NotificationsHomeOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - NotificationsHome Preseneter
protocol NotificationsHomePresenterProtocol: class {
    var view: NotificationsHomeViewProtocol? { get set}
    var interactor: NotificationsHomeInputInteractorProtocol? { get set}
    var router: NotificationsHomeRouterProtocol? { get set }
    var localization: NotificationsHomeLocalization { get }
    // view -> Presenter
    func viewDidLoad()
}
// MARK: - NotificationsHome View
protocol NotificationsHomeViewProtocol: class {
    var presenter: NotificationsHomePresenterProtocol! { get set }
    // Presenter -> View
    func setupNavBar(withTitle title: String)
    func setupUI()
    func setupNotificationsTableView()
    func reloadNotificationsTableView()
}
