//
//  PackageViewModel.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 23/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
struct PackageViewModel {
    // MARK: - Attributes
    private(set) var name: String
    private(set) var details: String
    private(set) var price: String
    private(set) var image: String
    // MARK: - Init
    init(package: Package) {
        self.name = package.name
        self.image = package.image
        self.details = package.packageDescription
        self.price = String(package.price)
    }
}
