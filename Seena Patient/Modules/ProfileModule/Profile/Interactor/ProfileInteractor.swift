//
//  ProfileInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 29/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ProfileInteractor: ProfileInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: ProfileOutputInteractorProtocol?
    var localDataManager: ProfileLocalDataManagerProtocol
    var remoteDataManager: AuthenticationRemoteDataManagerProtocol
    // MARK: - Init
    init(remoteDataManager: AuthenticationRemoteDataManager,
         localDataManager: ProfileLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func retriveUser() {
        presenter?.onRetriveUser(localDataManager.retriveUser())
    }
    func removeUser() {
        localDataManager.removeUserData()
        UserDefaults.standard.removeObject(forKey: "firstSignUpToken")
        UserDefaults.standard.removeObject(forKey: "Uploaded")
        UserDefaults.standard.removeObject(forKey: "UploadSignin")
        UserDefaults.standard.removeObject(forKey: "Signin")
        UserDefaults.standard.removeObject(forKey: "status")
        UserDefaults.standard.removeObject(forKey: "PackagePhone")
        UserDefaults.standard.removeObject(forKey: "walletMoney")

        

    }
    func retriveApplicationStatus() {
        remoteDataManager.retriveApplicationStatus(token: localDataManager.retriveToken())
//        let tok = UserDefaults.standard.string(forKey: "firstSignUpToken")
//        remoteDataManager.retriveApplicationStatus(token: tok!)

        { [weak self] (results) in
            guard let self = self else {return}
            switch results {
            case .failure:
                self.presenter?.onRetriveApplicationStatusFail()
            case .success(let data):
                guard let data = data as? BaseResponse<ApplicationStatusResponse>, data.serverResonse.code == 200, let status = data.response?.status else {
                    self.presenter?.onRetriveApplicationStatusFail()
                    return
                }
                self.presenter?.onRetrieApplicationStatusSuccess(status)
            }
        }
    }
}
