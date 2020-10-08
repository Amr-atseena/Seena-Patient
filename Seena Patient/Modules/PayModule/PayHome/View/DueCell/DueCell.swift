//
//  DueCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 07/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class DueCell: UITableViewCell {
    // MARK: - Attributes
    @IBOutlet var clinicNameLabel: UILabel!
    @IBOutlet var paymentDateLabel: UILabel!
    @IBOutlet var clinicPlaceHolderLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // clinicName Label
        clinicNameLabel.font = DesignSystem.Typography.subHeading2.font
        // clinicPlaceHolder Label
        clinicPlaceHolderLabel.font = DesignSystem.Typography.heading.font
        // paymentDate Label
        paymentDateLabel.font = DesignSystem.Typography.title2.font
        // amount Label
        amountLabel.font = DesignSystem.Typography.subHeading4.font
    }
}
// MARK: - DueCell Protocol
extension DueCell: DueCellProtocol {
    func setPaymentDue(_ due: PaymentDueViewModel) {
        clinicNameLabel.text = due.clinicName
        clinicPlaceHolderLabel.text = due.clinicPlaceHolder
        amountLabel.text = due.amount
        paymentDateLabel.text = due.paymentDate
    }
}
