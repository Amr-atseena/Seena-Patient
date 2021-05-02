//
//  ClinicsSectionHeaderCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ClinicsSectionHeaderCell: UITableViewCell {
    @IBOutlet private var specialityNameLabel: UILabel!
    @IBOutlet private var seeAllButton: UIButton!
    var seeAllButtonTapped: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // categoryName Label
        specialityNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        specialityNameLabel.font = DesignSystem.Typography.subHeading2.font
        // seeAll Button
        seeAllButton.setTitleColor(DesignSystem.Colors.primaryActionBackground.color, for: .normal)
        seeAllButton.titleLabel?.font = DesignSystem.Typography.subHeading4.font
        seeAllButton.setTitle("See All".localized, for: .normal)
    }
    @IBAction private func didTappSeeAllButton(_ sender: UIButton) {
        seeAllButtonTapped?()
    }
}
extension ClinicsSectionHeaderCell: ClinicsSectionHeaderCellProtocol {
    func setSpeciality(name: String) {
        specialityNameLabel.text = name
    }
}
