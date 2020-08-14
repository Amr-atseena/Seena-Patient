//
//  String+Extensions.swift
//  Breeders
//
//  Created by RKAnjel on 4/27/20.
//  Copyright © 2020 SatFinder. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self + "KEY")
    }
}

extension String {
    func isValidUserName() -> Bool {
        return  self.isValidEmail() || self.isValidPhone()
      }
    func isValidEmail() -> Bool {
          let emailRegEx =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
          let emailValidion = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let isValid = emailValidion.evaluate(with: self)
          return isValid
      }
    func isValidPhone() -> Bool {
          let phoneRegEx = "[0-9]{6,14}$"
          let phoneValidion = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        let isValid = phoneValidion.evaluate(with: self)
          return isValid
      }
    func isValidPassword() -> Bool {
          if self.count >= 6 {
              return true
          } else {
              return false
          }
      }
}
