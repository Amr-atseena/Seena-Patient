//
//  SplashRemoteDataManager.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
class SplashRemoteDataManager: APIService<SplashEndPoint>, SplashRemoteDataManagerProtocol {
    func retriveMetaData(completionHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        request(target: .splash, objType: BaseResponse<SplashResponse>.self, completionHandler: completionHandler)
    }
    func sendFCMToken(serial: String, token: String, auth: String, completionHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        request(target: .fcmToken(serial, token, auth), objType: BaseResponse<Response>.self, completionHandler: completionHandler)
    }
}
