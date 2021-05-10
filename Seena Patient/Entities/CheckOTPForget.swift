//
//  CheckOTPForget.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/9/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

struct CheckOTPForget: Decodable{
    let error: CheckOTPForgetError
    let response: CheckOTPForgetResponse

       enum CodingKeys: String, CodingKey {
           case error = "Error"
           case response = "Response"
       }
   }

   // MARK: - Error
   struct CheckOTPForgetError: Decodable {
       let status: Bool
       let code: Int
       let validation, desc, token: String
   }

   // MARK: - Response
   struct CheckOTPForgetResponse: Decodable {
       let otp: String

       enum CodingKeys: String, CodingKey {
           case otp = "OTP"
       }
   }
