//
//  UploadVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class UploadVC: UIViewController, UploadViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var uploadKeywordLabel: UILabel!
    @IBOutlet private var uploadButton: UIButton!
    @IBOutlet private var finishButton: UIButton!
    @IBOutlet private var imagesCollectionView: UICollectionView!
    @IBOutlet private var loadingIndictor: UIActivityIndicatorView!
    // MARK: - Attributes
    var presenter: UploadPresenterProtocol!
    private lazy var imagePicker: ImagePicker = {
        return ImagePicker(presentationController: self, delegate: self)
    }()
    // MARK: - Init
    init() {
        super.init(nibName: UploadVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    // MARK: - Methods
    func setupUI() {
        //uploadKeyword Label
        uploadKeywordLabel.text = presenter.localization.uploadDocs
        uploadKeywordLabel.font = DesignSystem.Typography.subHeading4.font
        //finish Button
        finishButton.setTitle(presenter.localization.finish, for: .normal)
        finishButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font
        //upload Button
        uploadButton.setTitle(presenter.localization.upload, for: .normal)
        uploadButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font
    }
    func setupImagesCollectionView() {
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(cellWithClass: UploadImageCell.self)
    }
    func showLoadingIndictor() {
        loadingIndictor.startAnimating()
    }
    func hideLoadingIndictor() {
        loadingIndictor.stopAnimating()
    }
    func enableFinishButton() {
        finishButton.isUserInteractionEnabled = true
        finishButton.backgroundColor = DesignSystem.Colors.primaryActionBackground.color
    }
    func disableFinishButton() {
        finishButton.isUserInteractionEnabled = false
        finishButton.backgroundColor = DesignSystem.Colors.primaryBorder.color
    }
    func openImagePicker() {
        imagePicker.present(from: uploadButton)
    }
    func reoladImages() {
        imagesCollectionView.reloadData()
    }
    // MARK: - Actions
    @IBAction func didTapUploadButton(_ sender: UIButton) {
        presenter.uploadButtonTapped()
    }
    @IBAction func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    @IBAction func didTapFinishButton(_ sender: UIButton) {
        presenter.finishButtonTapped()
    }
    // MARK: - DeInit
    deinit {
         debugPrint(UploadVC.className + " Release from Momery")
    }
}
// MARK: - ImagePickerDelegate Implementation
extension UploadVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        presenter.imageSelected((image?.jpegData(compressionQuality: 0.8)))
    }
}
// MARK: - Images CollectionView DataSource
extension UploadVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfImages
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: UploadImageCell.self, for: indexPath)
        presenter.config(UploadImageCell: cell, atIndex: indexPath.item)
        cell.deleteImage = { [weak self] in
            guard  let self = self else { return}
            self.presenter.deleteImageButtonTapped(atIndex: indexPath.item)
        }
        return cell
    }
}
// MARK: - Images CollectionView Delegate
extension UploadVC: UICollectionViewDelegate {
}
// MARK: - Images CollectionView FlowLayout
extension UploadVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width  - 20) / 2
        let height: CGFloat = 150
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  5.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
