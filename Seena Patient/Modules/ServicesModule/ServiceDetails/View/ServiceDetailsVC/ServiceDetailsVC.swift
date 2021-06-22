//
//  ServiceDetailsVC.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/16/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import SkeletonView
class ServiceDetailsVC: UIViewController, ServiceDetailsViewProtocol {
    // MARK: - Outlets
    @IBOutlet var serviceImage: UIImageView!
    @IBOutlet var serviceNameLabel: UILabel!
    @IBOutlet var serviceDetailsLabel: UILabel!
    @IBOutlet var rangePriceKeywordLabel: UILabel!
    @IBOutlet var clinicsProvidingServiceKeywordLabel: UILabel!
    @IBOutlet var rangePriceLabel: UILabel!
    @IBOutlet var clinicsCollectionView: UICollectionView!
    @IBOutlet weak var callBtn: UIButton!
    // MARK: - Attributes
    var presenter: ServiceDetailsPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: ServiceDetailsVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        callBtn.setTitle("Call".toLocalize, for: .normal)
    }
    // MARK: - Methods
    func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setupUI() {
        // service name label
        serviceNameLabel.textColor = DesignSystem.Colors.secondaryText.color
        serviceNameLabel.font = DesignSystem.Typography.subHeading2.font
        // service Details label
        serviceDetailsLabel.textColor = DesignSystem.Colors.secondaryText.color
        serviceDetailsLabel.font = DesignSystem.Typography.title3.font
        // range price keyword label
        rangePriceKeywordLabel.text = presenter.localization.priceRange
        rangePriceKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        rangePriceKeywordLabel.font = DesignSystem.Typography.subHeading2.font
        // range price label
        rangePriceLabel.textColor = DesignSystem.Colors.secondaryText.color
        rangePriceLabel.font = DesignSystem.Typography.title2.font
        // cilnics providing service label
        clinicsProvidingServiceKeywordLabel.text = presenter.localization.clinicsProvidingService
        clinicsProvidingServiceKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        clinicsProvidingServiceKeywordLabel.font = DesignSystem.Typography.subHeading2.font
    }
    func setupClinicsCollectionView() {
        clinicsCollectionView.delegate = self
        clinicsCollectionView.dataSource = self
        clinicsCollectionView.register(cellWithClass: ServiceClinicCell.self)
        clinicsCollectionView.register(cellWithClass: ServiceResultSkeltonCell.self)
    }
    func updateUI(withService service: ServiceViewModel) {
        self.serviceNameLabel.text = service.serviceName
        self.serviceImage.kf.setImage(with: URL(string: service.serviceImage))
        self.serviceDetailsLabel.text = service.seriveDetails
        self.rangePriceLabel.text = service.servicePrice
    }
    func reloadClinics() {
        self.clinicsCollectionView.reloadData()
    }
    func showSkelton() {
        self.clinicsCollectionView.showSkeleton()
    }
    func hideSkelton() {
        self.clinicsCollectionView.hideSkeleton()
    }
    // MARK: - Actions
    @IBAction private func didTapShareButton(_ sender: UIButton) {
        presenter.shareButtonTapped()
    }
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    // MARK: - Deinit
    deinit {
        debugPrint(ServiceDetailsVC.className + " Release from Momery")
    }

    @IBAction func call(_ sender: Any) {
        makeCall(toNumber: "16938")
    }

    private func makeCall(toNumber number: String) {
        guard let numberURL =  URL(string: "tel://\(number)") else {
            return
        }
        UIApplication.shared.open(numberURL)
    }

}

// MARK: - ClinicsCollectionView DataSoucrce Implementation
extension ServiceDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfClinics
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ServiceClinicCell.self, for: indexPath)
        presenter.config(clinicCell: cell, atIndex: indexPath.item)
        return cell
    }
}
// MARK: - clinicsCollectionView Delegate Implementation
extension ServiceDetailsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectClinic(atIndex: indexPath.item)
    }
}

// MARK: - clinicsCollectionView FlowLayoutDelegate Implementation
extension ServiceDetailsVC: UICollectionViewDelegateFlowLayout {
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
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
extension ServiceDetailsVC: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ServiceResultSkeltonCell.className
    }
}
