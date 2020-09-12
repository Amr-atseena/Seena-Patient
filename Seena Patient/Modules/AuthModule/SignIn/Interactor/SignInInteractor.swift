//
//  SignInInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class SignInInteractor: SignInInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: SignInOutputInteractorProtocol?
    var remoteDataManager: AuthenticationRemoteDataManagerProtocol
    init(remoteDataManager: AuthenticationRemoteDataManagerProtocol) {
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func login(withPhone phone: String, andPassword password: String) {
        guard !phone.isEmpty && phone.isValidPhone() else {
            presenter?.onLoginFail(withMessage: "In Valid Phone Number")
            return
        }
        guard !password.isEmpty && password.isValidPassword() else {
            presenter?.onLoginFail(withMessage: "In Valid Password")
            return
        }
        let params = LoginRequestParameters(phone: phone, password: password)
        remoteDataManager.retriveLoginData(params: params) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.presenter?.onLoginFail(withMessage: error.localizedDescription)
            case .success(let response):
                guard let response = response as? BaseResponse<LoginResponse> else {
                    return
                }
                guard let user = response.response?.user, response.serverResonse.code == 200 else {
                    self.presenter?.onLoginFail(withMessage: response.serverResonse.desc)
                    return
                }
                self.presenter?.onLoginSuccess()
            }
        }
    }
}
