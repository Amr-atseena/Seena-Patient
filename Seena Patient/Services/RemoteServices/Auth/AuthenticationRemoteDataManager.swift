//
//  AuthenticationRemoteDataManager.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
class AuthenticationRemoteDataManager: APIService<AuthenticationEndPoint>, AuthenticationRemoteDataManagerProtocol {
    func upload(params: UploadRequestParamaters, complationHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        request(target: .upload(params), objType: BaseResponse<LoginResponse>.self, completionHandler: complationHandler)
    }
    func retriveLoginData(params: LoginRequestParameters, complationHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        request(target: .login(params), objType: BaseResponse<LoginResponse>.self, completionHandler: complationHandler)
    }
    func retriveSignUpData(params: SignUpRequestParamaters, complationHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        request(target: .signUp(params), objType: BaseResponse<LoginResponse>.self, completionHandler: complationHandler)
    }
    func retriveApplicationStatus(token: String, complationHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        request(target: .applicationStatus(token), objType: BaseResponse<ApplicationStatusResponse>.self, completionHandler: complationHandler)
    }
}
