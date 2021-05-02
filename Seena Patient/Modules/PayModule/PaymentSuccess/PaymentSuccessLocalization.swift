//
//  PaymentSuccessLocalization.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct PaymentSuccessLocalization {
    // MARK: - Attributes
    var accountNumber: String {
        return "Account Number".localized
    }
    var paymentSuccess: String {
        return "Payment Success".localized
    }
    var done: String {
        return "Done".localized
    }
    var paymentBody: String {
        return "Thanks for your payment; Seena will revise the payment and if any trouble is encountered we will get back to you.".localized
    }
}
