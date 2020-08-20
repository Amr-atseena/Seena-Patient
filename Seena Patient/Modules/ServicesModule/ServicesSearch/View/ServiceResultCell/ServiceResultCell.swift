//
//  ServiceResultCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/17/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ServiceResultCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private var serviceImage: UIImageView!
    @IBOutlet private var serviceNameLabel: UILabel!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // serviceName label
        serviceNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        serviceNameLabel.font = DesignSystem.Typography.subHeading.font
    }
}
