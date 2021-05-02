//
//  TransactionCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet private var clinicNameLabel: UILabel!
    @IBOutlet private var paymentDateLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var paymentStatusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // clinicName Label
        clinicNameLabel.font = DesignSystem.Typography.subHeading3.font
        // paymentStatus Label
        paymentStatusLabel.font = DesignSystem.Typography.title2.font
        // paymentDate Label
        paymentDateLabel.font = DesignSystem.Typography.title2.font
        // amount Label
        amountLabel.font = DesignSystem.Typography.subHeading4.font
    }
}
extension TransactionCell: TransactionCellProtocol {
    func setTransaction(_ transaction: TransactionViewModel) {
        amountLabel.text = transaction.amount
        amountLabel.textColor = transaction.statusColor
        paymentDateLabel.text = transaction.paymentDate
        paymentStatusLabel.text = transaction.paymentStatus
        clinicNameLabel.text = transaction.clinicName
    }
}
