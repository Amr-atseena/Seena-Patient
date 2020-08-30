//
//  ServicesRemoteServiceProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

protocol ServicesRemoteServiceProtocol {
    func fetchServicesHome(completionHandler:  @escaping (_ result: Result<Codable, Error>) -> Void)
    func fetchServicesList(parms: ServicesListParameters, completionHandler:  @escaping (_ result: Result<Codable, Error>) -> Void)
    func fetchServicesDetails(forServiceId serviceId: Int, completionHandler:  @escaping (_ result: Result<Codable, Error>) -> Void)
}
