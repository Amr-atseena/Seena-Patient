//
//  ClinicsSearchLocalization.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct ClinicsSearchLocalization {
    // MARK: - Attributes
    var results: String {
        return "Results".localized
    }
    var searchPlaceholder: String {
        return "Search by Clinic".localized
    }
    var noResultsHeaderKeyword: String {
        return "We tried looking;".localized
    }
    var noResultsbodyKeyword: String {
        return "found nothing!".localized
    }
}
