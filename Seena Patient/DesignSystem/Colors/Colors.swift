//
//  Colors.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
extension DesignSystem {
    enum Colors: String {
        case primaryBackground
        case secondaryBackground
        case primaryText
        case secondaryText
        case primaryActionText
        case secondaryActionText
        case headingText
        case pending
        case accept
        case primaryActionBackground
        case secondroyActionBackground
        case selectedTabBar
        case unSelectedTabBar
        case primaryBorder
        case secondaryBorder
        case primaryNavBarBackground
        case secondaryNavBarBackground
        case primaryNavBarText
        case payStart
        case payEnd
        case primarySelectedActionBackground
        var color: UIColor {
            return UIColor(named: self.rawValue)!
        }
    }
}
