//
//  ClinicsRemoteDataManangerProtocol.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
protocol ClinicsRemoteDataManangerProtocol {
   func retriveClinicsList(parms: ClinicsListParameters, completionHandler:  @escaping (_ result: Result<Codable, Error>) -> Void)
    func retriveClinicDetails(atClinicId clinicId: Int, completionHandler:  @escaping (_ result: Result<Codable, Error>) -> Void)
}
