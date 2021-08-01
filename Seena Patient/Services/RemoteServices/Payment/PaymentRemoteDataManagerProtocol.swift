//
//  PaymentRemoteDataManagerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 28/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
protocol PaymentRemoteDataManagerProtocol: class {
    func retrivePayment(token: String , status :String , completionHandler: @escaping ((_ result: Result<Codable, Error>) -> Void))
    func retriveTransactions(token: String, completionHandler: @escaping ((_ result: Result<Codable, Error>) -> Void))
    func payInstallment(token: String, payment: Payment, completionHandler: @escaping ((_ result: Result<Codable, Error>) -> Void))
}
