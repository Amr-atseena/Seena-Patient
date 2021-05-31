//
//  SplashResponse.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 04/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - SplashResponse
struct SplashResponse: Codable {
    let cities: [City]
    let idTypes: [Document]
    let financialProof: [Document]
    let residenceProof: [Document]
    let accounts: [Account]
    let vCash: [Vodafone]
    let plans: [Plan]
    let isInReview: Bool
    let eCash: [Etisalat]

}
