//
//  ServiceViewModel.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
struct ServiceViewModel {
    // MARK: - Attributes
    let serviceName: String
    let serviceImage: String
    let seriveDetails: String
    let servicePrice: String
    // MARK: - Init
    init(service: Service?) {
        self.serviceName = service?.name ?? ""
        self.serviceImage = service?.image ?? ""
        self.seriveDetails = service?.serviceDescription ?? ""
        self.servicePrice = String(describing: service?.priceMin ?? 0) + " - " + String(describing: service?.priceMax ?? 0)
    }
}
