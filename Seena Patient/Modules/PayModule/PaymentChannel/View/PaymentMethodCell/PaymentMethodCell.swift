//
//  PaymentMethodCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 07/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PaymentMethodCell: UITableViewCell {
    @IBOutlet private var methodNameLabel: UILabel!
    @IBOutlet private var holderView: UIView!
    override var isSelected: Bool {
        didSet {
            if isSelected {
                holderView.backgroundColor = DesignSystem.Colors.primaryActionBackground.color
                methodNameLabel.textColor = DesignSystem.Colors.headingText.color
            } else {
                holderView.backgroundColor = DesignSystem.Colors.secondroyActionBackground.color
                methodNameLabel.textColor = DesignSystem.Colors.secondaryText.color
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // methodName Label
        methodNameLabel.font = DesignSystem.Typography.subHeading3.font
    }
}
// MARK: - PaymentMethodCellProtocol implementation
extension PaymentMethodCell: PaymentMethodCellProtocol {
    func setMethod(option: OptionViewModel) {
        methodNameLabel.text = option.name
        isSelected = option.isSelected
    }
}
