//
//  TransactionViewModel.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 10/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
struct TransactionViewModel {
    let clinicName: String
    let paymentDate: String
    let paymentStatus: String
    let amount: String
    let statusColor: UIColor
    init(transaction: Transaction) {
        self.clinicName = transaction.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let date = dateFormatter.date(from: transaction.dueDate) ?? Date()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        self.paymentDate = dateFormatter.string(from: date)
        self.paymentStatus = transaction.status.localization
        self.amount =  String(transaction.amount) + " " + "EGP".localized
        switch transaction.status {
        case .paid: self.statusColor = DesignSystem.Colors.accept.color
        case .purchased: self.statusColor = DesignSystem.Colors.secondaryText.color
        case .rejected: self.statusColor = DesignSystem.Colors.primaryActionBackground.color
        }
    }
}
