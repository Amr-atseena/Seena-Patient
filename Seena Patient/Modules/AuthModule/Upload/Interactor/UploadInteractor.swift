//
//  UploadInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class UploadInteractor: UploadInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: UploadOutputInteractorProtocol?
    var localDataManager: UploadLocalDataManagerProtocol
    var remoteDataManager: AuthenticationRemoteDataManager
    // MARK: - Init
    init(localDataManager: UploadLocalDataManagerProtocol,
         remoteDataManager: AuthenticationRemoteDataManager) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func upload(images: [Data], forType type: Int) {
//        let tok = UserDefaults.standard.string(forKey: "firstSignUpToken")
//        let params = UploadRequestParamaters(images: images, documentType: type, token: tok!)

        let params = UploadRequestParamaters(images: images, documentType: type, token: localDataManager.retriveToken())
        print(params.token)
        remoteDataManager.upload(params: params) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.presenter?.onUploadImagesFail(withError: error.localizedDescription)
            case .success(let response):
                guard let response = response as? BaseResponse<LoginResponse> else {
                    return
                }

                print(response)
                guard let user = response.response?.user,
                      let status = response.response?.status,
                      response.serverResonse.code == 200 else {
                    self.presenter?.onUploadImagesFail(withError: response.serverResonse.desc)
                    return
                }
                if status.financialProof && status.idType &&
                    status.profilePicture && status.residenceProof {
                    self.localDataManager.save(user: user)
                    UserDefaults.standard.set(true, forKey: "Uploaded")
                }

                if status.financialProof == true {
                    UserDefaults.standard.set(true, forKey: "financialProof")
                }
                if status.idType == true {
                    UserDefaults.standard.set(true, forKey: "idType")
                }
                if status.profilePicture == true {
                    UserDefaults.standard.set(true, forKey: "profilePicture")
                }
                if status.residenceProof == true {
                    UserDefaults.standard.set(true, forKey: "residenceProof")
                }


                self.presenter?.onUploadImagesSuccess(withStatus: status)
            }
        }
    }
}
