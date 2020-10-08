//
//  Payment.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct Payment {
    var installment: Installment
    var paymentMethod: Int
    var account: AccountViewModel
    var tansactionId: String = ""
}
