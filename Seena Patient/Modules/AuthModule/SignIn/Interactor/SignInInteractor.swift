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
    var localDataManager: AuthenticationLocalDataManagerProtocol
    init(localDataManager: AuthenticationLocalDataManagerProtocol,
         remoteDataManager: AuthenticationRemoteDataManagerProtocol) {
        self.remoteDataManager = remoteDataManager
        self.localDataManager = localDataManager
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
                guard let user = response.response?.user,
                    let status = response.response?.status,
                    response.serverResonse.code == 200 else {
                        self.presenter?.onLoginFail(withMessage: response.serverResonse.desc)
                        return
                }
                UserDefaults.standard.set(true, forKey: "Signin")
                self.localDataManager.save(user: user)

                if status.financialProof && status.idType &&
                    status.profilePicture && status.residenceProof {
                    self.localDataManager.save(user: user)
                    UserDefaults.standard.set(true, forKey: "UploadSignin")
                }
                self.localDataManager.save(token: response.serverResonse.token)

                let id = response.response?.status?.idType
                let fin = response.response?.status?.financialProof
                let resd = response.response?.status?.residenceProof

                if id == false || fin == false || resd == false  {
                    UserDefaults.standard.set(false, forKey: "Statuss")
                }else{
                    UserDefaults.standard.set(true, forKey: "Statuss")
                }

                if status.financialProof == true {
                    UserDefaults.standard.set(true, forKey: "financialProofLogin")
                }else{
                    UserDefaults.standard.set(false, forKey: "financialProofLogin")
                }
                if status.idType == true {
                    UserDefaults.standard.set(true, forKey: "idTypeLogin")
                }else{
                    UserDefaults.standard.set(false, forKey: "idTypeLogin")
                }
                if status.profilePicture == true {
                    UserDefaults.standard.set(true, forKey: "profilePictureLogin")
                }else{
                    UserDefaults.standard.set(false, forKey: "profilePictureLogin")
                }
                if status.residenceProof == true {
                    UserDefaults.standard.set(true, forKey: "residenceProofLogin")
                }else{
                    UserDefaults.standard.set(false, forKey: "residenceProofLogin")
                }

                print(response.response?.user?.status)
                UserDefaults.standard.set(response.response?.user!.status, forKey: "status")

                self.presenter?.onLoginSuccess(withStatus: status)


            }
        }
    }
}
