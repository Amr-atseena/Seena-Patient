//
//  ClinicsViewModel.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import Foundation

struct ClinicsViewModel {
    // MARK: - Attributes
    let clinicsName: String
    let clinicsNameImage: String
    let clinicsDetails: String
//    let servicePrice: String
    // MARK: - Init
    init(service: Service?) {
        self.clinicsName = service?.name ?? ""
        self.clinicsNameImage = service?.image ?? ""
        self.clinicsDetails = service?.serviceDescription ?? ""
//        self.servicePrice = String(describing: service?.priceMin ?? 0) + " - " + String(describing: service?.priceMax ?? 0) + " " + "EGP".localized
    }
}
