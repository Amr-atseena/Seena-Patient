//
//  CategoryCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var servicesCollectionView: UICollectionView!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        categoryNameLabel.font = DesignSystem.Typography.subHeading.font
        servicesCollectionView.register(cellWithClass: ServiceCell.self)
    }
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        servicesCollectionView.delegate = dataSourceDelegate
        servicesCollectionView.dataSource = dataSourceDelegate
        servicesCollectionView.tag = row
        servicesCollectionView.reloadData()
    }
}
extension CategoryCell: CategoryCellView {
    func setCategoryName(_ categoryName: String) {
        categoryNameLabel.text = categoryName
    }
}
