//
//  ServiceResultCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 29/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ServiceResultCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet private var serviceImage: UIImageView!
    @IBOutlet private var serviceNameLabel: UILabel!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // serviceName label
        serviceNameLabel.textColor = DesignSystem.Colors.headingText.color
        serviceNameLabel.font = DesignSystem.Typography.subHeading4.font
    }
}
// MARK: - Implementation Of ServicesSearchCellView Protocol
extension ServiceResultCell: ServicesSearchCellViewProtocol {
    func setService(_ service: ServiceViewModel) {
        self.serviceImage.kf.setImage(with: URL(string: service.serviceImage))
        self.serviceNameLabel.text = service.serviceName
    }
}
