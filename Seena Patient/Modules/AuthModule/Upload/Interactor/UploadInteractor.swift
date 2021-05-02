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
        let tok = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzI0YmM3YTQxZjk3NTVmNWFmZDc5YzUzMGYyOWRmZWFiOTdmZDYwNmE0ZWQ5OTk2NDEyZjg1OGY4MjEyNGUxYzIzYTlhNzhmZDMwMGI2ZmUiLCJpYXQiOjE2MTk3NDIzMjksIm5iZiI6MTYxOTc0MjMyOSwiZXhwIjoxNjUxMjc4MzI5LCJzdWIiOiIxOTQiLCJzY29wZXMiOltdfQ.qI6v_ejBHaipQwiRpqwGy_lVVXBphd6R5t6e3v06s1rqQD7OUCX1OWfz3PHPdi9gAjlUJG9Hd6V_eUFDtH2pQpJcUDyp47j8dJnp0D1U5NrHUq54copDhHNSaY61s3mnO0nx4XnQ3NBtcE-4bDjddlZhgRLXRmekEwz-zPwFoKqDqen9h2pboG-aNHcZ8xxuyILGdYestM_7KUXctI8Rcmzp7_mAxAJ7n3Eb4ezZrmQJCVI3eGqsAu56Q4z9HoybzohTZaYm3GW3dfWl1bpB0R7XyX_CoDI-cFUw_yUE8wE_tFg7HF4JZv1KdufP2G0zXFd7Djyh26Tel9d-ohVk2pU8WPZoRaI377n7vuhoo08q1hBy_OmS-11ikHhpE1rPd4kaqWF8fCeeVdJjBmYCcakNPUQ0MnOAk0pATX5JxiByk2HMkezzsPNzNiP6WPvS0N512Ka8ywloUxc2a77mC0Q5Ut4gLiN-ug4yg6CEK2BQ6yPpJLHDFaH7l9VbBC_LTk17fRYd8XcQjWmUjx6njDvU7H9SVLChqxiwnCuo2mjDii3dF9VGNPM0RlpEbTTBcjdg9CdvQ1DceeJLB3d0rmmsj10I0wmVsjoIQSJuAfW0dmGEsMjv7KUI2k5GqYCNRz3AF06fhFM3M3n8MOFMVK39d_Rm_4rvDoU-g4xPryY"
        let params = UploadRequestParamaters(images: images, documentType: type, token: tok)

//        let params = UploadRequestParamaters(images: images, documentType: type, token: localDataManager.retriveToken())
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
                guard let user = response.response?.user,
                      let status = response.response?.status,
                      response.serverResonse.code == 200 else {
                    self.presenter?.onUploadImagesFail(withError: response.serverResonse.desc)
                    return
                }
                if status.financialProof && status.idType &&
                    status.profilePicture && status.residenceProof {
                    self.localDataManager.save(user: user)
                }
                self.presenter?.onUploadImagesSuccess(withStatus: status)
            }
        }
    }
}
