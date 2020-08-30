//
//  ClinicDetailsVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ClinicDetailsVC: UIViewController, ClinicDetailsViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var clinicImage: UIImageView!
    @IBOutlet private var clinicNameLabel: UILabel!
    @IBOutlet private var clinicAddressLabel: UILabel!
    @IBOutlet private var callButton: UIButton!
    @IBOutlet private var ourWorkKeywordLabel: UILabel!
    @IBOutlet private var ourServicesKeywordLabel: UILabel!
    @IBOutlet private var imageGalleryCollectionView: UICollectionView!
    @IBOutlet private var servicesCollectionView: UICollectionView!
    // MARK: - Attributes
    var presenter: ClinicDetailsPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: ClinicDetailsVC.className, bundle: nil)
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
        // clinicName Label
        clinicNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        clinicNameLabel.font = DesignSystem.Typography.subHeading2.font
        // clinicAddress Label
        clinicAddressLabel.textColor = DesignSystem.Colors.secondaryText.color
        clinicAddressLabel.font = DesignSystem.Typography.title3.font
        // call Button
        callButton.setTitle(presenter.localization.call, for: .normal)
        callButton.setTitleColor(DesignSystem.Colors.primaryActionText.color, for: .normal)
        callButton.backgroundColor = DesignSystem.Colors.primaryActionBackground.color
        callButton.titleLabel?.font = DesignSystem.Typography.subHeading4.font
        // ourWork Label
        ourWorkKeywordLabel.text = presenter.localization.ourWork
        ourWorkKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        ourWorkKeywordLabel.font = DesignSystem.Typography.subHeading2.font
        // ourServices Label
        ourServicesKeywordLabel.text = presenter.localization.ourServices
        ourServicesKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        ourServicesKeywordLabel.font = DesignSystem.Typography.subHeading2.font
    }
    func setupGalleryCollectionView() {
        imageGalleryCollectionView.dataSource = self
        imageGalleryCollectionView.delegate = self
        imageGalleryCollectionView.register(cellWithClass: GalleryCell.self)
    }
    func setupServicesCollectionView() {
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        servicesCollectionView.register(cellWithClass: ServiceCell.self)
    }
    // MARK: - Actions
    @IBAction private func didTapCallButton(_ sender: UIButton) {
        presenter.callButtonTapped()
    }
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    // MARK: - DeInit
    deinit {
        debugPrint(ClinicDetailsVC.className + " Release from Momery")
    }
}
// MARK: - ServicesCollection DataSoucrce Implementation
extension ClinicDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageGalleryCollectionView {
            return presenter.numberOfImages
        } else {
            return presenter.numberOfServices
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageGalleryCollectionView {
            let cell = collectionView.dequeueReusableCell(withClass: GalleryCell.self, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: ServiceCell.self, for: indexPath)
            return cell
        }
    }
}
// MARK: - ServicesCollection Delegate Implementation
extension ClinicDetailsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imageGalleryCollectionView {
            presenter.galleryCollectionView(selectedAtIndex: indexPath.item)
        } else {
            presenter.serviesCollectionView(selectedAtIndex: indexPath.item)
        }
    }
}

// MARK: - ServicesCollection FlowLayoutDelegate Implementation
extension ClinicDetailsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width  - 30) / 3.25
        let height = (collectionView.frame.size.height)
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  5.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
