//
//  DueCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 07/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import MOLH

class DueCell: UITableViewCell {
    // MARK: - Attributes
    @IBOutlet var clinicNameLabel: UILabel!
    @IBOutlet var paymentDateLabel: UILabel!
    @IBOutlet var clinicPlaceHolderLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet weak var dueContainer: UIView!
    @IBOutlet weak var status: UILabel!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // clinicName Label
        clinicNameLabel.font = DesignSystem.Typography.subHeading4.font
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
        if MOLHLanguage.isArabic(){
            status.text = due.statusar
        }else{
        status.text = due.status
        }
        

//            if due.active == 1 && due.status == "rejected" {
//                dueContainer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//                amountLabel.textColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
//                paymentDateLabel.textColor = UIColor(named: "primaryText")
//                status.textColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
//            }else if due.active == 0 && due.status == "pending" {
//                dueContainer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//                amountLabel.textColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
//                status.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
//                paymentDateLabel.textColor = UIColor(named: "primaryText")
//            } else if due.active == 1 && due.status == "".localized{
//                dueContainer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//                amountLabel.textColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
//                paymentDateLabel.textColor = UIColor(named: "primaryText")
//                status.textColor = UIColor(named: "secondaryText")
//            }else if due.active == 0 && due.status == "unpaid" {
//                dueContainer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//                amountLabel.textColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
//                paymentDateLabel.textColor = UIColor(named: "primaryText")
//                status.textColor = UIColor(named: "secondaryText")
//            }else{}


    }
}
