//
//  AuthenticationRemoteDataManager.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
class AuthenticationRemoteDataManager: APIService<AuthenticationEndPoint>, AuthenticationRemoteDataManagerProtocol {
    func retriveLoginData(params: LoginRequestParameters, complationHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        request(target: .login(params), objType: BaseResponse<LoginResponse>.self, completionHandler: complationHandler)
    }
}
