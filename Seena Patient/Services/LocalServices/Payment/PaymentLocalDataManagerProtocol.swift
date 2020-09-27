//
//  PaymentLocalDataManagerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 26/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
protocol PaymentLocalDataManagerProtocol {
    func save(bankAccount: [Account])
    func retriveBackAccount() -> [Account]
    func save(vodafoneAccount: [Vodafone])
    func retriveVodafoneAccount() -> [Vodafone]
}

extension PaymentLocalDataManagerProtocol {
    func save(bankAccount: [Account]) {
        let data = try? JSONEncoder().encode(bankAccount)
        UserDefaults.standard.set(data, forKey: "BANKACCOUNT")
    }
    func retriveBackAccount() -> [Account] {
        let data = UserDefaults.standard.data(forKey: "BANKACCOUNT")!
        let account = try? JSONDecoder().decode([Account].self, from: data)
        return account ?? []
    }
    func save(vodafoneAccount: [Vodafone]) {
        let data = try? JSONEncoder().encode(vodafoneAccount)
        UserDefaults.standard.set(data, forKey: "VODAFONEACCOUNT")
    }
    func retriveVodafoneAccount() -> [Vodafone] {
        let data = UserDefaults.standard.data(forKey: "VODAFONEACCOUNT")!
        let account = try? JSONDecoder().decode([Vodafone].self, from: data)
        return account ?? []
    }

}
