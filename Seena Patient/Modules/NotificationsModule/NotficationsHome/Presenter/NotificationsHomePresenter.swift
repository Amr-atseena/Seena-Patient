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
        view?.reloadNotificationsTableView()
    }
}
// MARK: - NotificationsHomeOutputInteractorProtocol Implementation
extension NotificationsHomePresenter: NotificationsHomeOutputInteractorProtocol {
}
