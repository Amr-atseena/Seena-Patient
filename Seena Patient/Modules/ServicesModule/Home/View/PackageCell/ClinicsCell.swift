//
//  ClinicsCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit
import Kingfisher

class ClinicsCell: UICollectionViewCell {
    @IBOutlet weak var clinicsImage: UIImageView!
    @IBOutlet weak var clinicsName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        clinicsName.textColor = DesignSystem.Colors.headingText.color
        clinicsName.font = DesignSystem.Typography.subHeading2.font
    }

}

// MARK: - Implementation Of ClinicsCellView Protocol
//extension ClinicsCell: ClinicsCellProtocol {
//    func setClinic(_ clinic: ClinicsViewModel) {
//        clinicsName.text = clinic.clinicsName
//        clinicsImage.kf.setImage(with: URL(string: clinic.clinicsNameImage))
//
//    }
//
//}

extension ClinicsCell: PackageCellView {
    func setPackage(_ package: PackageViewModel) {
        clinicsName.text = "package.name"
        clinicsImage.kf.setImage(with: URL(string: package.image))
    }
}
