//
//  SignUpSecond.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/5/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

struct SignUpSecond : Decodable{

    let error: SignUpSecondError?
    let response: SignUpSecondResponse?

       enum CodingKeys: String, CodingKey {
           case error = "Error"
           case response = "Response"
       }
   }

   // MARK: - Error
   struct SignUpSecondError: Decodable {
       let status: Bool
       let code: Int
       let validation, desc, token: String
   }

   // MARK: - Response
   struct SignUpSecondResponse: Decodable {
       let otp: String

       enum CodingKeys: String, CodingKey {
           case otp = "OTP"
       }

}
