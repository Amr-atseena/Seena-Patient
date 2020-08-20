//
//  File.swift
//  Breeders
//
//  Created by RKAnjel on 4/29/20.
//  Copyright © 2020 SatFinder. All rights reserved.
//

import UIKit
import Foundation
extension UICollectionView {
    func register<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        register(UINib(nibName: T.className, bundle: nil), forCellWithReuseIdentifier: T.className)
    }
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }
}
