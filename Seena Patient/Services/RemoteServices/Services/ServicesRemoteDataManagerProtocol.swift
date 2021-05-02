//
//  ServicesRemoteServiceProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

protocol ServicesRemoteDataManagerProtocol {
    func fetchServicesHome(completionHandler:  @escaping (_ result: Result<Codable, Error>) -> Void)
    func fetchServicesList(parms: ServicesListParameters, completionHandler:  @escaping (_ result: Result<Codable, Error>) -> Void)
    func retriveServicesDetails(atServiceId serviceId: Int, completionHandler:  @escaping (_ result: Result<Codable, Error>) -> Void)
}
