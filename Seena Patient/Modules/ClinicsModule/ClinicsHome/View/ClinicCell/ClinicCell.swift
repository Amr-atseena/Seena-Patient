//
//  ClinicCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ClinicCell: UITableViewCell {
    @IBOutlet private var clinicNameLabel: UILabel!
    @IBOutlet private var clinicAddressLabel: UILabel!
    @IBOutlet private var clinicImage: UIImageView!
    @IBOutlet private var callButton: UIButton!
    var callButtonTapped: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // clinicName Label
        clinicNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        clinicNameLabel.font = DesignSystem.Typography.subHeading3.font
        // clinicAddress Label
        clinicAddressLabel.textColor = DesignSystem.Colors.primaryText.color
        clinicAddressLabel.font = DesignSystem.Typography.title3.font
        // call Button
        callButton.titleLabel?.font = DesignSystem.Typography.subHeading4.font
        callButton.setTitle("Call".localized, for: .normal)
    }
    @IBAction private func didTapCallButton(_ sender: UIButton) {
        callButtonTapped?()
    }
}
// MARK: - ClinicCell Protocol Implementation
extension ClinicCell: ClinicCellProtocol {
    func setClinic(_ clinic: ClinicViewModel) {
        clinicNameLabel.text = clinic.name
        clinicAddressLabel.text = clinic.address
        clinicImage.kf.setImage(with: URL(string: clinic.image))
    }
}
