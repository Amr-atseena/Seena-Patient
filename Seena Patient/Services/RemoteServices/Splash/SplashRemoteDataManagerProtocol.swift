//
//  SplashRemoteDataManagerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
protocol SplashRemoteDataManagerProtocol: class {
    func retriveMetaData(completionHandler: @escaping ((_ result: Result<Codable, Error>) -> Void))
    func sendFCMToken(serial: String, token: String, auth: String, completionHandler: @escaping ((_ result: Result<Codable, Error>) -> Void))
}
