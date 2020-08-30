//
//  ServiceOfTheWeakCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import Kingfisher
class PackageCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet private var serviceImage: UIImageView!
    @IBOutlet private var serviceName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        serviceName.textColor = DesignSystem.Colors.headingText.color
        serviceName.font = DesignSystem.Typography.subHeading2.font
    }
}
// MARK: - Implementation Of PackageCellView Protocol
extension PackageCell: PackageCellView {
    func setPackage(_ package: PackageViewModel) {
        serviceName.text = package.name
        serviceImage.kf.setImage(with: URL(string: package.image))
    }
}
