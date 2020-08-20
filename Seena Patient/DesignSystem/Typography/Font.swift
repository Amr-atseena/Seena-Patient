//
//  Font.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import MOLH
enum Font {
    case regular
    case medium
    case semiBold
    case bold
    var name: String {
        switch self {
        case .regular:
            return MOLHLanguage.isArabic() ? "Tajawal-Regular" : "AvenirNext-Regular"
        case .medium:
            return MOLHLanguage.isArabic() ? "Tajawal-Medium" : "AvenirNext-Medium"
        case .semiBold:
             return MOLHLanguage.isArabic() ? "Tajawal-Bold" : "AvenirNext-Demibold"
        case .bold:
            return MOLHLanguage.isArabic() ? "Tajawal-ExtraBold" : "AvenirNext-Bold"
        }
    }
}
