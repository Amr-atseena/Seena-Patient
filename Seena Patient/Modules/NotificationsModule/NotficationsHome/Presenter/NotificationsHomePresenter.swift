//
//  NotificationsHomePresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class NotificationsHomePresenter: NotificationsHomePresenterProtocol {
    // MARK: - Attributes
    weak var view: NotificationsHomeViewProtocol?
    var interactor: NotificationsHomeInputInteractorProtocol?
    var router: NotificationsHomeRouterProtocol?
    let localization = NotificationsHomeLocalization()
    var numberOfNotifications: Int {
        return notifications.count
    }
    private var page = 0
    private var notifications = [Notification]()
    // MARK: - Init
    init(view: NotificationsHomeViewProtocol?, interactor: NotificationsHomeInputInteractorProtocol, router: NotificationsHomeRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setupNavBar(withTitle: "")
        view?.setupNotificationsTableView()
        view?.setupInifityScrolling()
    }
    func viewWillAppear() {
//        page = 0
        retriveNotifications()
    }
    func retriveNotifications() {
        if page == 0 {
            view?.showLoadingIndictor()
        }
        interactor?.retiveNotificationsList(foPage: page)
    }
    func config(notificationCell cell: NotificationCellProtocol, atIndex index: Int) {
        let notifcation = NotificationViewModel(notification: notifications[index])
        cell.setNotification(notifcation)
    }
}
// MARK: - NotificationsHomeOutputInteractorProtocol Implementation
extension NotificationsHomePresenter: NotificationsHomeOutputInteractorProtocol {
    func onRetiveNotificationsListSuccess(notifications: [Notification]) {
        self.notifications.append(contentsOf: notifications)
        view?.hideLoadingIndictor()
        if self.notifications.isEmpty {
            view?.showNoDataView()
        } else {
            view?.hideNoDataView()
            page += 1
        }
        view?.reloadNotifications()
    }
    func onRetriveNotificationListFail() {
        view?.hideLoadingIndictor()
        view?.showNoDataView()

    }
}
