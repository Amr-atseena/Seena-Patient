//
//  PayOptionCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PayOptionCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet private var bankImage: UIImageView!
    @IBOutlet private var accountNumberKeywordLabel: UILabel!
    @IBOutlet private var accountNumberLabel: UILabel!
    @IBOutlet private var checkImage: UIImageView!
    // MARK: - Attributes
    override var isSelected: Bool {
        didSet {
            checkImage.isHidden = !isSelected
        }
    }
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // accountNumberKeyword Label
        accountNumberKeywordLabel.font = DesignSystem.Typography.subHeading3.font
        // accountNumber Label
        accountNumberLabel.font = DesignSystem.Typography.title3.font
    }
}
// MARK: - PayOptionCellProtocol Implementation
extension PayOptionCell: PayOPtionCellProtocol {
    func setAccount(_ account: AccountViewModel) {
        accountNumberKeywordLabel.text = account.title
        accountNumberLabel.text = account.accountNumber
        bankImage.kf.setImage(with: URL(string: account.image))
    }    
}
