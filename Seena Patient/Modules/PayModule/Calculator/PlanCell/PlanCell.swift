//
//  PlanCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PlanCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var monthLabel: UILabel!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // amount Label
        amountLabel.font = DesignSystem.Typography.subHeading3.font
        // month Label
        monthLabel.font = DesignSystem.Typography.subHeading3.font
    }
}
// MARK: - PlanCell Protocol
extension PlanCell: PlanCellProtocol {
    func setPlan(amount: String, month: String) {
        amountLabel.text = amount
        monthLabel.text = month
    }
}
