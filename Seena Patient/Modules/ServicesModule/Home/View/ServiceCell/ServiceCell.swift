//
//  ServiceCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import Kingfisher
class ServiceCell: UICollectionViewCell {
    @IBOutlet private var serviceNameLabel: UILabel!
    @IBOutlet private var serviceImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        serviceNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        serviceNameLabel.font = DesignSystem.Typography.subHeading4.font
    }
}
// MARK: - Implementation Of ServiceCellView Protocol
extension ServiceCell: ServiceCellView {
    func setService(_ service: ServiceViewModel) {
        serviceNameLabel.text = service.serviceName
        serviceImage.kf.setImage(with: URL(string: service.serviceImage))
    }
}
