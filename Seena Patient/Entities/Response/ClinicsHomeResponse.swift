//
//  ClinicsHomeResponse.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 04/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - ClinicsHomeResponse
struct ClinicsHomeResponse: Codable {
    let clinicOfWeek: Clinic?
    let specialities: [Speciality]
}
