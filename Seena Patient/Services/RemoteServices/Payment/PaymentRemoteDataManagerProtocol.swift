//
//  PaymentRemoteDataManagerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 28/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
protocol PaymentRemoteDataManagerProtocol: class {
    func retrivePayment(token: String ,completionHandler: @escaping ((_ result: Result<Codable, Error>) -> Void))
    func retriveTransactions(token: String, completionHandler: @escaping ((_ result: Result<Codable, Error>) -> Void))
}
