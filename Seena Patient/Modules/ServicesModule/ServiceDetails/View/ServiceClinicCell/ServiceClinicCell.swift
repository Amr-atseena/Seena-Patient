//
//  ServiceClinicCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/16/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ServiceClinicCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet var clinicNameLabel: UILabel!
    @IBOutlet var clinicImage: UIImageView!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // clinicName Label
        clinicNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        clinicNameLabel.font = DesignSystem.Typography.subHeading4.font
    }
}
// MARK: - ClinicCellView Protocol Implementation
extension ServiceClinicCell: ClinicCellProtocol {
    func setClinic(_ clinic: ClinicViewModel) {
        clinicNameLabel.text = clinic.name
        clinicImage.kf.setImage(with: URL(string: clinic.image))
    }
}
