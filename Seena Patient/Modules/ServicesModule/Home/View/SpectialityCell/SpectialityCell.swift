//
//  SpecitalityCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class SpectialityCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet var spectialityNameLabel: UILabel!
    @IBOutlet var servicesCollectionView: UICollectionView!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        spectialityNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        spectialityNameLabel.font = DesignSystem.Typography.subHeading2.font
        servicesCollectionView.register(cellWithClass: ServiceCell.self)
    }
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        servicesCollectionView.delegate = dataSourceDelegate
        servicesCollectionView.dataSource = dataSourceDelegate
        servicesCollectionView.tag = row
        servicesCollectionView.reloadData()
    }
}
// MARK: - Implementation of SpecitalityCellView Protocol
extension SpectialityCell: SpecialityCellView {
    func setSpecialityName(_ specialityName: String) {
         spectialityNameLabel.text = specialityName
    }
}
