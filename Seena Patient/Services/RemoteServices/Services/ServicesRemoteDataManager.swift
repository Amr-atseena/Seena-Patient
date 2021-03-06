//
//  ServicesRemoteSerivce.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
class ServicesRemoteDataManager: APIService<ServicesEndPoint>, ServicesRemoteDataManagerProtocol {
    func fetchServicesList(parms: ServicesListParameters, completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        request(target: .servicesList(parms: parms), objType: BaseResponse<[Service]>.self, completionHandler: completionHandler)
    }
    func fetchServicesHome(completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        request(target: .home, objType: BaseResponse<HomeResponse>.self, completionHandler: completionHandler)
    }
    func retriveServicesDetails(atServiceId serviceId: Int, completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        request(target: .serviceDetails(serviceId: serviceId), objType: BaseResponse<Service>.self, completionHandler: completionHandler)
    }
}
