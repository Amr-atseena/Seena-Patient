//
//  ClinicsSectionHeaderCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ClinicsSectionHeaderCell: UITableViewCell {
    @IBOutlet private var categoryNameLabel: UILabel!
    @IBOutlet private var seeAllButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // categoryName Label
        categoryNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        categoryNameLabel.font = DesignSystem.Typography.subHeading2.font
        // seeAll Button
        seeAllButton.setTitleColor(DesignSystem.Colors.primaryActionBackground.color, for: .normal)
        seeAllButton.titleLabel?.font = DesignSystem.Typography.subHeading4.font    }
}
