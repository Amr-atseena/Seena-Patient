//
//  ClinicViewModel.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 03/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
struct ClinicViewModel {
    // MARK: - Attributes
    private(set) var name: String
    private(set) var address: String
    private(set) var image: String
    private(set) var phone: String
    // MARK: - Init
    init(clinic: Clinic?) {
        self.name = clinic?.name ?? ""
        self.address = clinic?.address ?? ""
        self.image = clinic?.image ?? ""
        self.phone = clinic?.phone ?? ""
    }
}
