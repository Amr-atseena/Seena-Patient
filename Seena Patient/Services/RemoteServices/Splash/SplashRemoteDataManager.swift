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
        request(target: .splash, objType: BaseResponse<[City]>.self, completionHandler: completionHandler)
    }
}
