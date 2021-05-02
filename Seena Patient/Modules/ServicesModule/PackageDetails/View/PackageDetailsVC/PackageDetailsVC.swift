//
//  PackageDetailsVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PackageDetailsVC: UIViewController, PackageDetailsViewProtocol {
    // MARK: - Outlets
    @IBOutlet var packageImage: UIImageView!
    @IBOutlet var packageNameLabel: UILabel!
    @IBOutlet var packageDetailsLabel: UILabel!
    @IBOutlet var priceKeywordLabel: UILabel!
    @IBOutlet var packagePriceLabel: UILabel!
    @IBOutlet var servicesInpackageKeywordLabel: UILabel!
    @IBOutlet var servicesCollectionView: UICollectionView!
    // MARK: - Attributes
    var presenter: PackageDetailsPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: PackageDetailsVC.className, bundle: nil)
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
    func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setupUI() {
        // service name label
        packageNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        packageNameLabel.font = DesignSystem.Typography.subHeading2.font
        // service Details label
        packageDetailsLabel.textColor = DesignSystem.Colors.secondaryText.color
        packageDetailsLabel.font = DesignSystem.Typography.title3.font
        // range price keyword label
        priceKeywordLabel.text = presenter.localization.price
        priceKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        priceKeywordLabel.font = DesignSystem.Typography.subHeading2.font
        // range price label
        packagePriceLabel.textColor = DesignSystem.Colors.secondaryText.color
        packagePriceLabel.font = DesignSystem.Typography.title2.font
        // cilnics providing service label
        servicesInpackageKeywordLabel.text = presenter.localization.servicsInPackage
        servicesInpackageKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        servicesInpackageKeywordLabel.font = DesignSystem.Typography.subHeading2.font
    }
    func setupServicesCollectionView() {
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        servicesCollectionView.register(cellWithClass: ServiceCell.self)
    }
    func updateUI(withPackage package: PackageViewModel) {
        packageNameLabel.text = package.name
        packageDetailsLabel.text = package.details
        packagePriceLabel.text =  package.price + " " + presenter.localization.egp + " " + presenter.localization.monthly
        packageImage.kf.setImage(with: URL(string: package.image))
    }
    // MARK: - Actions
    @IBAction private func didTapShareButton(_ sender: UIButton) {
        presenter.shareButtonTapped()
    }
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    // MARK: - DeInit
    deinit {
         debugPrint(PackageDetailsVC.className + " Release from Momery")
    }
}
// MARK: - ClinicsCollectionView DataSoucrce Implementation
extension PackageDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfServices
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ServiceCell.self, for: indexPath)
        presenter.config(serviceCell: cell, atIndex: indexPath.row)
        return cell
    }
}
// MARK: - servicesCollectionView Delegate Implementation
extension PackageDetailsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - clinicsCollectionView FlowLayoutDelegate Implementation
extension PackageDetailsVC: UICollectionViewDelegateFlowLayout {
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
