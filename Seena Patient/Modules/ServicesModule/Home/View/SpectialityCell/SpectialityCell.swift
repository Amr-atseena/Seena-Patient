//
//  SpecitalityCell.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import MOLH

class SpectialityCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet var spectialityNameLabel: UILabel!
    @IBOutlet var servicesCollectionView: UICollectionView!
    @IBOutlet weak var seeAllBtn: UIButton!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        spectialityNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        spectialityNameLabel.font = DesignSystem.Typography.subHeading2.font
        servicesCollectionView.register(cellWithClass: ServiceCell.self)

        if MOLHLanguage.isArabic(){
            servicesCollectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft

        }else{
            servicesCollectionView.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight

        }
        
    }


    var callBack : (()->())?

    @IBAction func seeAll(_ sender: Any) {
        callBack?()
    }
    

    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        servicesCollectionView.delegate = dataSourceDelegate
        servicesCollectionView.dataSource = dataSourceDelegate
        servicesCollectionView.tag = row
        servicesCollectionView.reloadData()
    }
}
// MARK: - Implementation of SpecitalityCellView Protocol
extension SpectialityCell: SpecialityCellView, ClinicCellProtocol {
    func setClinic(_ clinic: ClinicViewModel) {
//        spectialityNameLabel.text = clinic.name
    }

    func setSpecialityName(_ specialityName: String) {
        if specialityName == "Sponsored" {
            spectialityNameLabel.text = "Sponsored"
            seeAllBtn.isHidden = false
        }else{
            seeAllBtn.isHidden = false
            spectialityNameLabel.text = specialityName
        }
    }
}

//extension ClinicCell: ClinicCellProtocol {
//    func setClinic(_ clinic: ClinicViewModel) {
//        clinicNameLabel.text = clinic.name
//        clinicAddressLabel.text = clinic.address
//        clinicImage.kf.setImage(with: URL(string: clinic.image))
//    }
//}
