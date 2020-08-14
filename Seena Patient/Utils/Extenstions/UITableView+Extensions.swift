//
//  UITableView+Extension.swift
//  Sat-Finder
//
//  Created by ٍٍSat Finder on 2/27/20.
//  Copyright © 2020 SatFinder. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(UINib(nibName: T.className, bundle: nil), forCellReuseIdentifier: T.className)
    }
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }
}
