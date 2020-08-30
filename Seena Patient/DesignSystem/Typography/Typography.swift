//
//  Typography.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
extension DesignSystem {
    enum Typography {
        case largeTitle
        case heading
        case subHeading1
        case subHeading2
        case subHeading3
        case subHeading4
        case title1
        case title2
        case title3
        private var fontDiscriptor: CustomFontDiscriptor {
            switch self {
            case .largeTitle:
                return CustomFontDiscriptor(font: .bold, size: 38, style: .largeTitle)
            case .heading:
                return CustomFontDiscriptor(font: .bold, size: 30, style: .headline)
            case .subHeading1:
                return CustomFontDiscriptor(font: .semiBold, size: 28, style: .subheadline)
            case .subHeading2:
                return CustomFontDiscriptor(font: .semiBold, size: 24, style: .subheadline)
            case .subHeading3:
                return CustomFontDiscriptor(font: .semiBold, size: 20, style: .subheadline)
            case .subHeading4:
                return CustomFontDiscriptor(font: .semiBold, size: 16, style: .subheadline)
            case .title1:
                return CustomFontDiscriptor(font: .medium, size: 28, style: .title1)
            case .title2:
                return CustomFontDiscriptor(font: .regular, size: 16, style: .title2)
            case .title3:
                return CustomFontDiscriptor(font: .regular, size: 14, style: .title3)
            }
        }
        var font: UIFont {
            guard let font = UIFont(name: fontDiscriptor.font.name, size: fontDiscriptor.size) else {
                return UIFont.preferredFont(forTextStyle: fontDiscriptor.style)
            }
            let fontMatrics = UIFontMetrics(forTextStyle: fontDiscriptor.style)
            return fontMatrics.scaledFont(for:
                font)
        }
    }
}
