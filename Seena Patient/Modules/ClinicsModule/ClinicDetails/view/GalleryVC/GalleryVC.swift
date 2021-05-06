//
//  GalleryVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 11/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController {
    @IBOutlet var galleryImage: UIImageView!
    private var image: String = ""
    // MARK: - Init
    init(image: String) {
        super.init(nibName: GalleryVC.className, bundle: nil)
        self.image = image
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryImage.kf.setImage(with: URL(string: image))
    }
    @IBAction func didDissmisButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
