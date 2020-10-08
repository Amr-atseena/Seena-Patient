//
//  PaymentRemoteDataManager.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 28/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
class PaymentRemoteDataManager: APIService<PaymentEndPoint>, PaymentRemoteDataManagerProtocol {
    func retrivePayment(token: String, completionHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        request(target: .paymentHome(token), objType: BaseResponse<PaymentHomeResponse>.self, completionHandler: completionHandler)
    }
    func retriveTransactions(token: String, completionHandler: @escaping ((Result<Codable, Error>) -> Void)) {
        request(target: .transactions(token), objType: ServerResonse.self, completionHandler: completionHandler)
    }
}
