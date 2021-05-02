//
//  SignUpInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class SignUpInteractor: SignUpInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: SignUpOutputInteractorProtocol?
    var localDataManager: SignUpLocalDataManagerProtocol
    var remoteDataManager: AuthenticationRemoteDataManagerProtocol
    // MARK: - Init
    init(localDataManager: SignUpLocalDataManagerProtocol,
         remoteDataManager: AuthenticationRemoteDataManagerProtocol) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func retriveIdTypes() {
        presenter?.onRetriveIdTypes(localDataManager.retrivDocumets(forKey: .id))
    }
    func retriveResidenceProof() {
        presenter?.onRetriveResidenceProof(localDataManager.retrivDocumets(forKey: .residence))
    }
    func retriveFinancialProof() {
        presenter?.onRetriveFinancialProof(localDataManager.retrivDocumets(forKey: .financial))
    }
    func signUp(withParam param: SignUpRequestParamaters) {
        guard param.phone.isValidPhone() else {
            presenter?.onSignUpFail(withError: "invalid phone number")
            return
        }
        guard param.password.isValidPassword() else {
            presenter?.onSignUpFail(withError: "invalid password")
            return
        }
        guard param.password == param.confirmPassword  else {
            presenter?.onSignUpFail(withError: "passwords do not match")
            return
        }
        remoteDataManager.retriveSignUpData(params: param) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.presenter?.onSignUpFail(withError: error.localizedDescription)
            case .success(let response):
                guard let response = response as? BaseResponse<LoginResponse> else {
                    return
                }
                guard let status = response.response?.status,
                    response.serverResonse.code == 200 else {
                    self.presenter?.onSignUpFail(withError: response.serverResonse.desc)
                        return
                }
                self.localDataManager.save(token: response.serverResonse.token)
                self.presenter?.onSignUpSuccess(withStatus: status)
            }
        }
    }
}
