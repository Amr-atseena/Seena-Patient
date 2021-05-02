//
//  AppResources.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 22/01/2021.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit
import MOLH


struct AppResources {
    static let fonts = SeenaFonts()
    static let colors = SeenaColors()
    static let images = SeenaImages()
}

struct SeenaImages {
}
struct SeenaColors {
    
}
struct SeenaFonts {
    func seena(styleForEnglish enStyle: FontStyle, styleForArabic arStyle: FontStyle) -> UIFont {
        return MOLHLanguage.isArabic() ? tajawal(style: arStyle) : avenirNext(style: enStyle)
    }
    func tajawal(style: FontStyle) -> UIFont {
        return AppFonts.tajawal(style).value ?? UIFont()
    }
    func avenirNext(style: FontStyle) -> UIFont {
        return AppFonts.avenirNext(style).value ?? UIFont()
    }
}
enum AppFonts {
    case tajawal(FontStyle)
    case avenirNext(FontStyle)
}

enum FontStyle {
    case regular(CGFloat)
    case medium(CGFloat)
    case bold(CGFloat)
    case extraBold(CGFloat)
}

extension AppFonts {
    var value: UIFont? {
        switch self {
        case let .avenirNext(style):
            switch style {
            case let .regular(size):
                return UIFont(name: "AvenirNext-Regular", size: size)
            case let .medium(size):
                return UIFont(name: "AvenirNext-Medium", size: size)
            case let .bold(size):
                return UIFont(name: "AvenirNext-Demibold", size: size)
            case let .extraBold(size):
                return UIFont(name: "AvenirNext-Bold", size: size)
            }
        case let .tajawal(style):
            switch style {
            case let .regular(size):
                return UIFont(name: "Tajawal-Regular", size: size)
            case let .medium(size):
                return UIFont(name: "Tajawal-Medium", size: size)
            case let .bold(size):
                return UIFont(name: "Tajawal-Bold", size: size)
            case let .extraBold(size):
                return UIFont(name: "Tajawal-ExtraBold", size: size)
            }
        }
    }
}
