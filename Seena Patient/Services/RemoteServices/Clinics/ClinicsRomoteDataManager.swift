//
//  ClinicsRomoteDataManager.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
class ClinicsRomoteDataManager: APIService<ClinicsEndPoint>, ClinicsRemoteDataManangerProtocol {
    func retriveClinicsList(parms: ClinicsListParameters, completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        request(target: .clinicList(parms: parms), objType: BaseResponse<[Clinic]>.self, completionHandler: completionHandler)
    }
    func retriveClinicDetails(atClinicId clinicId: Int, completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        request(target: .clinicDetails(clinicId: clinicId), objType: BaseResponse<Clinic>.self, completionHandler: completionHandler)
    }
    func retriveClinicsHome(completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        request(target: .home, objType: BaseResponse<ClinicsHomeResponse>.self, completionHandler: completionHandler)
    }
}
