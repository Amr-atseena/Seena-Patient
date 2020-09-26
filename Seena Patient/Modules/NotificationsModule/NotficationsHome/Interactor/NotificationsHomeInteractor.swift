//
//  NotificationsHomeInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class NotificationsHomeInteractor: NotificationsHomeInputInteractorProtocol {
    var localDataManager: NotificationLocalDataManagerProtocol
    var remoteDataManager: NotificationsRemoteDataManagerProtocol
    // MARK: - Init
    init(localDataManager: NotificationLocalDataManagerProtocol,
         remoteDataManager: NotificationsRemoteDataManagerProtocol) {
        self.remoteDataManager = remoteDataManager
        self.localDataManager = localDataManager
    }
    // MARK: - Attributes
    weak var presenter: NotificationsHomeOutputInteractorProtocol?
    // MARK: - Methods
    func retiveNotificationsList(foPage page: Int) {
        let params = NotificationRequestParameters(token: localDataManager.retriveToken(), currentPage: page)
        remoteDataManager.retriveNotificationsList(parameters: params) { [weak self] (results) in
            guard let self = self else {return}
            switch results {
            case .failure:
                self.presenter?.onRetriveNotificationListFail()
            case .success(let data):
                guard let data = data as? BaseResponse<[Notification]>, data.serverResonse.code == 200 || data.serverResonse.code == 401 else {
                    self.presenter?.onRetriveNotificationListFail()
                    return
                }
                self.presenter?.onRetiveNotificationsListSuccess(notifications: data.response ?? [])
            }
        }
    }
}
