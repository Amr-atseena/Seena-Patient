//
//  APIClientSecond.swift
//  Seena Patient
//
//  Created by RKAnjel on 7/8/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation
import Alamofire

class APIClientSecond {


    //MARK:- get wallet limit
    func getWalletLimit(onSuccess: @escaping (Walletlimit) -> Void, onError: @escaping (_ error: String)-> Void) {

        let url = "http://dashboard.seenapay.com/api/limit"

        AF.request(URL(string: url)!, method: .get ,encoding: JSONEncoding.default).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(Walletlimit.self, from: jsonData)
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


    //MARK:- send user location

    func userLocation(latitude : Double, longitude : Double, onSuccess: @escaping (UserLocationModel) -> Void, onError: @escaping (_ error: String)-> Void) {

        let params = ["latitude" : latitude,"longitude" : longitude]
        let token = UserDefaults.standard.string(forKey: "TOKEN")
        let header = ["Authorization" : "Bearer " + token!] as HTTPHeaders?

        let url = "http://dashboard.seenapay.com/api/auth/AddUserLocation"

        AF.request(URL(string: url)!, method: .post, parameters: params ,encoding: JSONEncoding.default, headers: header).responseData {
            response in
            switch response.result {
            case .success(let jsonData):
                do {
                    print(jsonData)
                    let data = try JSONDecoder().decode(UserLocationModel.self, from: jsonData)
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
