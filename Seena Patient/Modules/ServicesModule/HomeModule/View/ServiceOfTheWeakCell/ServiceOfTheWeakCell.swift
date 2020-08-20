//
//  ServiceOfTheWeakCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ServiceOfTheWeakCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet var serviceImage: UIImageView!
    @IBOutlet var serviceName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        serviceName.textColor = DesignSystem.Colors.headingText.color
        serviceName.font = DesignSystem.Typography.subHeading.font
    }

}
