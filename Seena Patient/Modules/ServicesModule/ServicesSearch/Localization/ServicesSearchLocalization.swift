//
//  ServicesSearchLocalization.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/17/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct ServicesSearchLocalization {
    // MARK: - Attributes
    var results: String {
        return "Results".localized
    }
    var searchPlaceholder: String {
        return "Search by Service".localized
    }
    var noResultsHeaderKeyword: String {
        return "We tried looking;".localized
    }
    var noResultsbodyKeyword: String {
        return "found nothing!".localized
    }
}
