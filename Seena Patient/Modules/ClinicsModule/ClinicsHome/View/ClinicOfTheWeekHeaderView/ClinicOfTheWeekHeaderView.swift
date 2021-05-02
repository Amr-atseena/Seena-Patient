//
//  ClinicOfTheWeekHeaderView.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 22/01/2021.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class ClinicOfTheWeekHeaderView: UIView {
    // MARK: - Outlets
    @IBOutlet private var clinicOfWeekKeywordLabel: UILabel!
    @IBOutlet private var clinicOfWeekNameLabel: UILabel!
    @IBOutlet private var clinicOfWeakAddressLabel: UILabel!
    @IBOutlet private var clinicOfWeekCategoryLabel: UILabel!
    @IBOutlet private var clinicOfWeekImage: UIImageView!
    @IBOutlet private var callClinicButton: UIButton!
    // MARK: - Attributes
    var didTapCallButton: (() -> Void)?
    var didTapClinicOfTheWeeekButton: (() -> Void)?
    let localization = ClinicsHomeLocalization()
    // MARK: - Init
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 270))
    }
    override init(frame: CGRect) {
       super.init(frame: frame)
       setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    // MARK: - methods
    private func setupView() {
        let bundle = Bundle(identifier: ClinicOfTheWeekHeaderView.className)
        let nib = UINib(nibName: ClinicOfTheWeekHeaderView.className, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
        addSubview(view)
        view.fillInView(self)
        setupUI()
    }
    private func setupUI() {
        // clincsOfWeek Keyword label
        clinicOfWeekKeywordLabel.text = localization.clinicOfWeek
        clinicOfWeekKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        clinicOfWeekKeywordLabel.font = DesignSystem.Typography.subHeading2.font
        // clinicOfWeekName Label
        clinicOfWeekNameLabel.textColor = DesignSystem.Colors.headingText.color
        clinicOfWeekNameLabel.font =  AppResources.fonts.seena(styleForEnglish: .bold(24), styleForArabic: .bold(28))
        // clinicOfWeakAddress Label
        clinicOfWeakAddressLabel.textColor = DesignSystem.Colors.headingText.color
        clinicOfWeakAddressLabel.font = AppResources.fonts.seena(styleForEnglish: .regular(16), styleForArabic: .regular(18))
       // clinicOfWeekCategory Label
        clinicOfWeekCategoryLabel.textColor = DesignSystem.Colors.headingText.color
        clinicOfWeekCategoryLabel.font = DesignSystem.Typography.subHeading3.font
        // call Clinic Button
        callClinicButton.titleLabel?.font = DesignSystem.Typography.subHeading4.font
        callClinicButton.setTitle(localization.call, for: .normal)
        callClinicButton.setTitleColor(DesignSystem.Colors.primaryActionBackground.color, for: .normal)
        callClinicButton.backgroundColor = DesignSystem.Colors.primaryActionText.color
    }
    func setClinicOfTheWeek(_ clinic: ClinicViewModel) {
        clinicOfWeekNameLabel.text = clinic.name
        clinicOfWeakAddressLabel.text = clinic.address
        clinicOfWeekImage.kf.setImage(with: URL(string: clinic.image))
        clinicOfWeekCategoryLabel.text = ""
    }
    func showSkeleton() {
        clinicOfWeekImage.showAnimatedGradientSkeleton()
        clinicOfWeekNameLabel.showAnimatedGradientSkeleton()
        clinicOfWeakAddressLabel.showAnimatedGradientSkeleton()
        clinicOfWeekCategoryLabel.showAnimatedGradientSkeleton()
        callClinicButton.showAnimatedGradientSkeleton()
    }
    func hideSkeleton() {
        callClinicButton.hideSkeleton()
        clinicOfWeekCategoryLabel.hideSkeleton()
        clinicOfWeakAddressLabel.hideSkeleton()
        clinicOfWeekNameLabel.hideSkeleton()
        clinicOfWeekImage.hideSkeleton()
    }
    // MARK: - Actions
    @IBAction private func didTapCallButton(_ sender: UIButton) {
        didTapCallButton?()
    }
    @IBAction private func didTapClinicOfWeekButton(_ sender: UIButton) {
        didTapClinicOfTheWeeekButton?()
    }
}
