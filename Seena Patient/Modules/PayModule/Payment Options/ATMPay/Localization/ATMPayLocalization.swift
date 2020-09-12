//
//  ATMPayLocalization.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct ATMPayLocalization {
    // MARK: - Attributes
    var next: String {
        return "Next".localized
    }
    var payMessage: String {
        return "Please deposit your payment in any of the following bank accounts; select the bank you chose then click next".localized
    }
}
