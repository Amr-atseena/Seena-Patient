//
//  DueViewModel.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct PaymentDueViewModel {
    // MARK: - Attributes
    private(set) var clinicName: String
    private(set) var amount: String
    private(set) var clinicPlaceHolder: String
    private(set) var paymentDate: String
    private(set) var status: String
    private(set) var active: Int

    // MARK: - Init
    init(installment: Installment) {
        clinicName = installment.clinicName
        clinicPlaceHolder = installment.clinicName[0].uppercased()
        amount = String(installment.amount) + " " + "EGP".localized
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: installment.dueDate) ?? Date()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        paymentDate = dateFormatter.string(from: date)
        status = installment.status
        active = installment.active
    }
}
extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}
