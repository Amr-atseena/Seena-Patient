//
//  GalleryCell.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet var clinicWorkImage: UIImageView!
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
// MARK: - GalleryCell Protocol
extension GalleryCell: GalleryCellProtocol {
    func set(gallery: GalleryViewModel) {
        clinicWorkImage.kf.setImage(with: URL(string: gallery.image))
    }
}
