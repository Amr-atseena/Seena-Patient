//
//  OptionsAdapter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 04/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class OptionsAdapter: NSObject {
    // MARK: - Attributes
    private weak var presenter: OptionsAdapterProtocol?
    // MARK: - Init
    init(presenter: OptionsAdapterProtocol) {
        self.presenter = presenter
    }
}
// MARK: - OptionsAdapter Collection DataSource
extension OptionsAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfOptions ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: OptionCell.self, for: indexPath)
        presenter?.cnofig(optionCell: cell, atIndex: indexPath.item)
        return cell
    }
}
// MARK: - OptionsAdapter Collection Delegate
extension OptionsAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.optionCell(selectedAtIndex: indexPath.item)
    }
}
