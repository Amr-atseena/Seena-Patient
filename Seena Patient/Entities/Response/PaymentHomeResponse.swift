//
//  PaymentHomeResponse.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 28/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - PaymentHomeResponse
struct PaymentHomeResponse: Codable {
    let dueCredit, paidCredit, walletCredit: Int
    let installment: [Installment]
}
