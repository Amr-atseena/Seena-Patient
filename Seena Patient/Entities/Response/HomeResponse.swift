//
//  HomeResponse.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
// MARK: - HomeResponse
struct HomeResponse: Codable {
    let specialities: [Speciality]
    let packages: [Package]
    let sponsoredClinics: [Clinic]
    enum CodingKeys: String, CodingKey {
        case specialities, packages
        case sponsoredClinics = "SponsoredClinics"
    }
}
