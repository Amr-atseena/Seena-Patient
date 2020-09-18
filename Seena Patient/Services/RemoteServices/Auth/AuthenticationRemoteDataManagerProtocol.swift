//
//  AuthenticationRemoteDataManagerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

protocol AuthenticationRemoteDataManagerProtocol: class {
    func retriveLoginData(params: LoginRequestParameters, complationHandler: @escaping ((_ result: Result<Codable, Error>) -> Void))
    func retriveSignUpData(params: SignUpRequestParamaters, complationHandler: @escaping ((_ result: Result<Codable, Error>) -> Void))
}
