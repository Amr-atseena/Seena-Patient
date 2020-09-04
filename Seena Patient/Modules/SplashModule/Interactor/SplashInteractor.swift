//
//  SplashInteractor.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
class SplashInteractor: SplashInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: SplashOutputInteractorProtocol?
    var localDataManager: SplashLocalDataManagerProtocol
    var remoteDataManager: SplashRemoteDataManagerProtocol
    // MARK: - Init
    init(localDataManager: SplashLocalDataManagerProtocol, remoteDataManager: SplashRemoteDataManagerProtocol) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func retriveMetaData() {
        remoteDataManager.retriveMetaData { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.presenter?.onRetriveDataFail(error.localizedDescription)
            case .success(let response):
                guard let response = response as? BaseResponse<SplashResponse> else {
                    return
                }
                guard let cities = response.response?.cities, response.serverResonse.code == 200 else {
                    self.presenter?.onRetriveDataFail(response.serverResonse.desc)
                    return
                }
                self.localDataManager.save(cities: cities)
                self.presenter?.onRetriveMetaDataSuccess()
            }
        }
    }
}
