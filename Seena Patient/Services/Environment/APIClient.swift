//
//  APIClient.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/5/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation
import Alamofire



struct UserInfo {
    var firstName : String?
    var lastName : String?
    var password : String?
    var phone : String?
    var email: String?
    var birthdate: String?

}


class APIClient{

    //MARK:- signUpFirst


//    var users = UserInfo(firstName: "first_name", lastName: "last_name", password: "password", phone: "phone", email: "email", birthdate: "birth_date")


    func signUpFirst(userInfo: UserInfo , onSuccess: @escaping (SignUpFirst) -> Void, onError: @escaping (_ error: String)-> Void) {

        let params = ["email": userInfo.email, "phone" : userInfo.phone, "first_name": userInfo.firstName, "last_name": userInfo.lastName, "password": userInfo.password, "birth_date": userInfo.birthdate]

//        let url = "http://dashboard.seenapay.com/api/auth/register"

        let url = "http://dashboard.seenapay.com/api/auth/register?"

        AF.request(URL(string: url)!, method: .post, parameters: params, encoding: JSONEncoding.default).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    let data = try JSONDecoder().decode(SignUpFirst.self, from: jsonData)
                    print(data)
                    if (data.response != nil) {
                        onSuccess(data)
                    } else {
                        onError(data.error?.validation ?? "")
                    }
                } catch {
                    print("ParseError",error.localizedDescription)
                    onError(error.localizedDescription)
                }
                break
            case .failure(let error):
                print("Request error: \(error)")
                onError(error.localizedDescription)
                break
            }
        }
    }



    //MARK:- post otp code for signup

    func postOTPSignUp(otp : String, onSuccess: @escaping (OTPSignUpModel) -> Void, onError: @escaping (_ error: String)-> Void) {

                let params = ["OTP" : otp]
        let token = UserDefaults.standard.string(forKey: "firstSignUpToken")
        let header = ["Authorization" : "Bearer " + token!] as HTTPHeaders?

        let url = "http://dashboard.seenapay.com/api/auth/CheckOTP?"

        AF.request(URL(string: url)!, method: .post, parameters: params ,encoding: JSONEncoding.default, headers: header).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(OTPSignUpModel.self, from: jsonData)
                    print(data)
                    if data.response != nil {
                        onSuccess(data)
                    } else {
                        onError(data.error?.validation ?? "")
                    }
                } catch {
                    print("ParseError",error.localizedDescription)
                    onError(error.localizedDescription)
                }
                break
            case .failure(let error):
                print("Request error: \(error)")
                onError(error.localizedDescription)
                break
            }
        }
    }





    //MARK:- signUpsecond
//    func signUpsecond(birthdate: String, id: Int, financialProof: Int, ResidenceProof: Int, onSuccess: @escaping (SignUpSecond) -> Void, onError: @escaping (_ error: String)-> Void) {
//
//        let params = ["birthdate" : birthdate , "id" : id, "financialProof": financialProof, "ResidenceProof": ResidenceProof]
//
//        let url = "http://dashboard.seenapay.com/api/"
//
//        AF.request(URL(string: url)!, method: .post, parameters: params, encoding: JSONEncoding.default).responseData {
//            response in
//            switch response.result {
//            case .success(let jsonData):
//                do {
//                    let data = try JSONDecoder().decode("SignUpSecond".self, from: jsonData)
//                    print(data)
//                    if (data.response != nil) {
//                        onSuccess(data)
//                    } else {
//                        onError(data.error?.validation ?? "")
//                    }
//                } catch {
//                    print("ParseError",error.localizedDescription)
//                    onError(error.localizedDescription)
//                }
//                break
//            case .failure(let error):
//                print("Request error: \(error)")
//                onError(error.localizedDescription)
//                break
//            }
//        }
//    }





    //MARK:- forgetPassword

//    func forgetPassword(email: String , onSuccess: @escaping (ForgetPassModel) -> Void, onError: @escaping (_ error: String)-> Void) {
//
//        let params = ["email" : email]
//
//        let url = "http://dashboard.seenapay.com/api/"
//
//        AF.request(URL(string: url)!, method: .post, parameters: params, encoding: JSONEncoding.default).responseData {
//            response in
//            switch response.result {
//            case .success(let jsonData):
//                do {
//                    let data = try JSONDecoder().decode("SignUp".self, from: jsonData)
//                    print(data)
//                    if (data.response != nil) {
//                        onSuccess(data)
//                    } else {
//                        onError(data.error?.validation ?? "")
//                    }
//                } catch {
//                    print("ParseError",error.localizedDescription)
//                    onError(error.localizedDescription)
//                }
//                break
//            case .failure(let error):
//                print("Request error: \(error)")
//                onError(error.localizedDescription)
//                break
//            }
//        }
//    }


}
