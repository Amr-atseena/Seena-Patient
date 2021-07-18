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
    var image : UIImage?

}

struct PayParams {
    var image: UIImage?
    var installmentId : Int?
    var paymentMethod : Int?
    var id : Int?


}

class APIClient{

    //MARK:- signUpFirst

    func signUpFirst(userInfo: UserInfo , onSuccess: @escaping (SignUpFirst) -> Void, onError: @escaping (_ error: String)-> Void) {

        let params = ["email": userInfo.email, "phone" : userInfo.phone, "first_name": userInfo.firstName, "last_name": userInfo.lastName, "password": userInfo.password, "birth_date": userInfo.birthdate]

        //        let url = "http://dashboard.seenapay.com/api/auth/register"

        let url = "http://dashboard.seenapay.com/api/auth/register?"

        let imgData = userInfo.image != nil ? userInfo.image?.jpegData(compressionQuality: 0.5) : nil

        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append(value!.data(using: String.Encoding.utf8)!, withName: key)
            }
            if imgData != nil {
                multipartFormData.append(imgData!, withName: "image",fileName: "image.jpg", mimeType: "image/jpg")
            }

        }, to: URL(string: url)!,method: .post).responseData {
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
        let token = UserDefaults.standard.string(forKey: "TOKEN")
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



    // MARK:- signUpsecond
    func signUpsecond(iDType: String, financialProofType: String, residenceProofType: String, onSuccess: @escaping (SignUpSecond) -> Void, onError: @escaping (_ error: String)-> Void) {

        let params = ["IDType": iDType, "FinancialProofType" : financialProofType,"ResidenceProofType" : residenceProofType]
        //        let token = UserDefaults.standard.string(forKey: "firstSignUpToken")
        let token = UserDefaults.standard.string(forKey: "TOKEN") ?? ""

        let header = ["Authorization" : "Bearer " + token] as HTTPHeaders?

        let url = "http://dashboard.seenapay.com/api/auth/RegisterUserInfo?"

        AF.request(URL(string: url)!, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    let data = try JSONDecoder().decode(SignUpSecond.self, from: jsonData)
                    print(data)

                    UserDefaults.standard.set(true, forKey: "secondRegTrue")
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



    //MARK:- forgetPassword

    func forgetPassword(phone: String , onSuccess: @escaping (ForgetPassModel) -> Void, onError: @escaping (_ error: String)-> Void) {

        let params = ["Phone" : phone]

        let url = "http://dashboard.seenapay.com/api/auth/ForgetPass?"

        AF.request(URL(string: url)!, method: .post, parameters: params, encoding: JSONEncoding.default).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    let data = try JSONDecoder().decode(ForgetPassModel.self, from: jsonData)
                    print(data)
                    if (data.response != nil) {
                        onSuccess(data)
                    } else {
                        onError(data.error.validation ?? "")
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


    //MARK:- checkResetPass

    func checkResetPass(phone: String, resetOTP: String , onSuccess: @escaping (CheckOTPForget) -> Void, onError: @escaping (_ error: String)-> Void) {

        let params = ["Phone" : phone, "ResetOTP": resetOTP]

        let url = "http://dashboard.seenapay.com/api/auth/CheckResetPassOTP?"

        AF.request(URL(string: url)!, method: .post, parameters: params, encoding: JSONEncoding.default).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    let data = try JSONDecoder().decode(CheckOTPForget.self, from: jsonData)
                    print(data)
                    if (data.response != nil) {
                        onSuccess(data)
                    } else {
                        onError(data.error.validation ?? "")
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



    //MARK:- resetPass

    func resetPass(phone: String, newPassword: String , onSuccess: @escaping (ResetPassword) -> Void, onError: @escaping (_ error: String)-> Void) {

        let params = ["Phone" : phone, "NewPassword": newPassword]

        let url = "http://dashboard.seenapay.com/api/auth/ResetPassword?"

        AF.request(URL(string: url)!, method: .post, parameters: params, encoding: JSONEncoding.default).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    let data = try JSONDecoder().decode(ResetPassword.self, from: jsonData)
                    print(data)
                    if (data.response != nil) {
                        onSuccess(data)
                    } else {
                        onError(data.error.validation ?? "")
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



    //MARK:- GetSponsoredClincs

    func getSponsoredClincs(onSuccess: @escaping ([Clinic]) -> Void, onError: @escaping (_ error: String)-> Void) {


        //        let token = UserDefaults.standard.string(forKey: Keys.token)
        //        let header = ["Authorization" : "Bearer " + token!] as HTTPHeaders?

        let url = "http://dashboard.seenapay.com/api/clinic/sponsored"

        AF.request(URL(string: url)!, method: .get,encoding: JSONEncoding.default ).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    let data = try JSONDecoder().decode([Clinic].self, from: jsonData)
                    print(data)

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




    //MARK:- pay for doctor

    func payForDoctor(amount : String, paymentMethod : String, doctorID : String, inst : Int, onSuccess: @escaping (PayForDoctorModel) -> Void, onError: @escaping (_ error: String)-> Void) {

        let params = ["Amount" : amount,"PaymentMethod" : paymentMethod,"DoctorID" :doctorID,"installment_plans_ID" :"\(inst)"]
        let token = UserDefaults.standard.string(forKey: "TOKEN")
        let header = ["Authorization" : "Bearer " + token!] as HTTPHeaders?

        let url = "http://dashboard.seenapay.com/api/payment/payForDoctor"

        AF.request(URL(string: url)!, method: .post, parameters: params ,encoding: JSONEncoding.default, headers: header).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(PayForDoctorModel.self, from: jsonData)
                    print(data)
                    if data.response != nil {
                        onSuccess(data)
                    } else {
                        onError(data.error.validation ?? "")
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



    //MARK:- installment plans

    func installmentPlans(amount : Int, doctorID: Int, onSuccess: @escaping (InstallmentPlansModel) -> Void, onError: @escaping (_ error: String)-> Void) {

        //        let params = ["Amount" : amount]

        let url = "http://dashboard.seenapay.com/api/payment/installment_plans?Amount=\(amount)&doctor_id=\(doctorID)"

        AF.request(URL(string: url)!, method: .get ,encoding: JSONEncoding.default).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(InstallmentPlansModel.self, from: jsonData)
                    print(data)
                    if data.response != nil {
                        onSuccess(data)
                    } else {
                        onError(data.error.validation ?? "")
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



    //MARK:- transferCompleteOTP

    func transferCompleteOTP(otp : Int, onSuccess: @escaping (OTPtransferCompleteModel) -> Void, onError: @escaping (_ error: String)-> Void) {

        let params = ["OTP" : otp]
        let token = UserDefaults.standard.string(forKey: "TOKEN")
        let header = ["Authorization" : "Bearer " + token!] as HTTPHeaders?

        let url = "http://dashboard.seenapay.com/api/payment/transferComplete"

        AF.request(URL(string: url)!, method: .post, parameters: params ,encoding: JSONEncoding.default, headers: header).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(OTPtransferCompleteModel.self, from: jsonData)
                    print(data)
                    if data.response != nil {
                        onSuccess(data)
                    } else {
                        onError(data.error.validation ?? "")
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



    //MARK:- SignUP

    func uploadReceptCall(payParams: PayParams, onSuccess: @escaping (PaymentPay) -> Void, onError: @escaping (_ error: String)-> Void) {

        let token = UserDefaults.standard.string(forKey: "TOKEN")
        let header = ["Authorization" : "Bearer " + token!] as HTTPHeaders?

        let imgData = payParams.image != nil ? payParams.image?.jpegData(compressionQuality: 0.5) : nil

        let parameter = ["installment_id" : String(payParams.installmentId!) , "payment_method" : String(payParams.paymentMethod!), "id" : String(payParams.id!)]

        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameter {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            if imgData != nil {
                multipartFormData.append(imgData!, withName: "image",fileName: "image.jpg", mimeType: "image/jpg")
            }

        }, to: URL(string: "http://dashboard.seenapay.com/api/payment/pay")!,method: .post,headers: header).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    let data = try JSONDecoder().decode(PaymentPay.self, from: jsonData)
                    print(data)
                    if data.error.status {
                        onSuccess(data)
                    } else {
                        onError(data.error.desc)
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


    //MARK:- userStatus

    func getUserStatus(onSuccess: @escaping (GetUserStatus) -> Void, onError: @escaping (_ error: String)-> Void) {

        //        let params = ["Amount" : amount]

        let url = "http://dashboard.seenapay.com/api/auth/GetUserInfo"
        let token = UserDefaults.standard.string(forKey: "TOKEN")
        let header = ["Authorization" : "Bearer " + token!] as HTTPHeaders?

        AF.request(URL(string: url)!, method: .get ,encoding: JSONEncoding.default, headers: header).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(GetUserStatus.self, from: jsonData)
                    print(data)
                    if data.response != nil {
                        onSuccess(data)
                    } else {
                        onError(data.error.validation ?? "")
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



    func resendotp(onSuccess: @escaping (ResenOtp) -> Void, onError: @escaping (_ error: String)-> Void) {

        //        let params = ["Amount" : amount]

        let url = "http://dashboard.seenapay.com/api/auth/resendOTP"
        let token = UserDefaults.standard.string(forKey: "RegisterToken")
        let header = ["Authorization" : "Bearer " + token!] as HTTPHeaders?

        AF.request(URL(string: url)!, method: .get ,encoding: JSONEncoding.default, headers: header).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(ResenOtp.self, from: jsonData)
                    print(data)
                    if data.response != nil {
                        onSuccess(data)
                    } else {
                        onError(data.error.validation ?? "")
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



    //MARK:- Resend otp for payment

    func resendPaymentOTP(paymentID : Int, onSuccess: @escaping (ResendPaymentOtp) -> Void, onError: @escaping (_ error: String)-> Void) {

        let params = ["PaymentID" : paymentID]
        let token = UserDefaults.standard.string(forKey: "TOKEN")
        let header = ["Authorization" : "Bearer " + token!] as HTTPHeaders?

        let url = "http://dashboard.seenapay.com/api/payment/resendPaymentOTP"

        AF.request(URL(string: url)!, method: .post, parameters: params ,encoding: JSONEncoding.default, headers: header).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(ResendPaymentOtp.self, from: jsonData)
                    print(data)
                    if data.response != nil {
                        onSuccess(data)
                    } else {
                        onError(data.error.validation ?? "")
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




}
