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
                holderView.backgroundColor = DesignSystem.Colors.payStart.color
                holderView.layer.borderWidth = 0
            } else {
                holderView.backgroundColor = DesignSystem.Colors.headingText.color
                holderView.layer.borderWidth = 2
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // optionName Label
        optionNameLabel.font = DesignSystem.Typography.subHeading3.font
    }
}
// MARK: - OptionCellProtocol Implementation
extension OptionCell: OptionCellProtocol {
    func set(option: OptionViewModel) {
        optionNameLabel.text = option.name
        isSelected = option.isSelected
    }    
}
