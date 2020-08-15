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
        case primaryActionBackground
        case secondroyActionBackground
        case selectedTabBar
        case unSelectedTabBar
        case primaryBorder
        case secondaryBorder
        var color: UIColor {
            return UIColor(named: self.rawValue)!
        }
    }
}
