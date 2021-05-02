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
    var localDataManager: NotificationLocalDataManagerProtocol { get set }
    var remoteDataManager: NotificationsRemoteDataManagerProtocol { get set }
    // Presenter -> Interactor
    func retiveNotificationsList(foPage page: Int)
}
protocol NotificationsHomeOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetiveNotificationsListSuccess(notifications: [Notification])
    func onRetriveNotificationListFail()
}
// MARK: - NotificationsHome Preseneter
protocol NotificationsHomePresenterProtocol: class {
    var view: NotificationsHomeViewProtocol? { get set}
    var interactor: NotificationsHomeInputInteractorProtocol? { get set}
    var router: NotificationsHomeRouterProtocol? { get set }
    var localization: NotificationsHomeLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func viewWillAppear()
    func retriveNotifications()
    func config(notificationCell cell: NotificationCellProtocol, atIndex index: Int)
    var numberOfNotifications: Int { get }
}
// MARK: - NotificationsHome View
protocol NotificationsHomeViewProtocol: class {
    var presenter: NotificationsHomePresenterProtocol! { get set }
    // Presenter -> View
    func setupNavBar(withTitle title: String)
    func setupUI()
    func setupNotificationsTableView()
    func setupInifityScrolling()
    func reloadNotifications()
    func showLoadingIndictor()
    func hideLoadingIndictor()
    func showNoDataView()
    func hideNoDataView()
}
// MARK: - Notification Cell Protocol
protocol NotificationCellProtocol: class {
    func setNotification(_ notification: NotificationViewModel)
}
