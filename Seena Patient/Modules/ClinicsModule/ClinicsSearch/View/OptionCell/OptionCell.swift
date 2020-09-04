//
//  OptionCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 04/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class OptionCell: UICollectionViewCell {
    @IBOutlet var optionNameLabel: UILabel!
    @IBOutlet var holderView: UIView!
    override var isSelected: Bool {
        didSet {
            if isSelected {
                holderView.backgroundColor = DesignSystem.Colors.primarySelectedActionBackground.color
                holderView.layer.borderWidth = 0
                optionNameLabel.textColor = DesignSystem.Colors.headingText.color
            } else {
                holderView.backgroundColor = DesignSystem.Colors.headingText.color
                holderView.layer.borderWidth = 1
                optionNameLabel.textColor = DesignSystem.Colors.primaryText.color
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // optionName Label
        optionNameLabel.font = DesignSystem.Typography.title2.font
    }
}
// MARK: - OptionCellProtocol Implementation
extension OptionCell: OptionCellProtocol {
    func set(option: OptionViewModel) {
        optionNameLabel.text = option.name
        isSelected = option.isSelected
    }
}
