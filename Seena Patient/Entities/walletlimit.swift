//
//  walletlimit.swift
//  Seena Patient
//
//  Created by RKAnjel on 7/8/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

// MARK: - Walletlimit
struct Walletlimit: Codable {
    let error: WalletlimitError
    let response: WalletlimitResponse

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case response = "Response"
    }
}

// MARK: - Error
struct WalletlimitError: Codable {
    let status: Bool
    let code: Int
    let validation, desc, token: String
}

// MARK: - Response
struct WalletlimitResponse: Codable {
    let id: Int
    let name: String
    let limitWallet: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case limitWallet = "limit_wallet"
    }
}
