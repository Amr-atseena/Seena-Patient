//
//  HomeInteractor.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class HomeInteractor: HomeInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: HomeOutputInteractorProtocol?
    var remoteDataServices: ServicesRemoteDataManager?
    var localDataManager: ServicesLocalDataManagerProtocol
    // MARK: - Init
    init(localDataManager: ServicesLocalDataManagerProtocol,remoteServices: ServicesRemoteDataManager) {
        self.remoteDataServices = remoteServices
        self.localDataManager = localDataManager
    }
    // MARK: - Methods
    func retriveUser() {
        presenter?.onRetriveUserSuccess(withUser: localDataManager.retriveUser())
    }
    func fetchHomeServices() {
        remoteDataServices?.fetchServicesHome(completionHandler: { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .failure:
                self.presenter?.onRetriveDataFail()
            case .success(let response):
                guard let response = response as? BaseResponse<HomeResponse>, response.serverResonse.code == 200 else {
                    self.presenter?.onRetriveDataFail()
                    return
                }
                self.presenter?.onRetriveDataSuccess(with: response.response!)
            }
        })
    }
}
