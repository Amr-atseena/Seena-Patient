//
//  UploadOptionCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class DocumentTypeCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private var uploadCheckImage: UIImageView!
    @IBOutlet private var uploadTypeLabel: UILabel!
    @IBOutlet private var uploadBackgroundView: UIView!
    // MARK: - Attributes
    override var isSelected: Bool {
        didSet {
            if isSelected {
                uploadCheckImage.isHidden = false
                uploadBackgroundView.backgroundColor = DesignSystem.Colors.primaryActionBackground.color
            } else {
                uploadCheckImage.isHidden = true
                uploadBackgroundView.backgroundColor = DesignSystem.Colors.primaryBorder.color
            }
        }
    }
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // uploadType Label
        uploadTypeLabel.font = DesignSystem.Typography.subHeading2.font
    }
}
// MARK: - DocumentTypeCellProtocol Implemention
extension DocumentTypeCell: DocumentTypeCellProtocol {
    func setDocumentType(_ type: DocomentTypeViewModel) {
        uploadTypeLabel.text = type.name
        isSelected = type.isUploaded
    }
}
