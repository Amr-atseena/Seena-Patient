//
//  UploadImageCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 19/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class UploadImageCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet private var uploadImage: UIImageView!
    // MARK: - Attributes
    var deleteImage: (() -> Void)?
    // MARK: - Actions
    @IBAction private func didTapDeleteButton(_ sender: UIButton) {
        deleteImage?()
    }
}
// MARK: - UploadImageCellProtocol Impelemtation
extension UploadImageCell: UploadImageCellProtocol {
    func setImage(_ image: Data) {
        uploadImage.image = UIImage(data: image)
    }
}
