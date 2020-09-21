//
//  SettingsVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, SettingsViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var settingsKeywordLabel: UILabel!
    @IBOutlet private var pushNotificationsKeywordLabel: UILabel!
    @IBOutlet private var paymentReminderKeywordLabel: UILabel!
    @IBOutlet private var languageKeywordLabel: UILabel!
    @IBOutlet private var rateAppKeywordLabel: UILabel!
    // MARK: - Attributes
    var presenter: SettingsPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: SettingsVC.className, bundle: nil)
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
        // settingsKeyword Label
        settingsKeywordLabel.text = presenter.localization.settings
        settingsKeywordLabel.font = DesignSystem.Typography.heading.font
        // pushNotificationsKeyword Label
        pushNotificationsKeywordLabel.text = presenter.localization.pushNotifications
        pushNotificationsKeywordLabel.font = DesignSystem.Typography.subHeading4.font
        // paymentReminderKeyword Label
        paymentReminderKeywordLabel.text = presenter.localization.sendPaymentReminders
        paymentReminderKeywordLabel.font = DesignSystem.Typography.subHeading4.font
        // languageKeyword Label
        languageKeywordLabel.text = presenter.localization.language
        languageKeywordLabel.font = DesignSystem.Typography.subHeading4.font
        // rateAppKeywordLabel Label
        rateAppKeywordLabel.text = presenter.localization.rateApp
        rateAppKeywordLabel.font = DesignSystem.Typography.subHeading4.font
    }
    // MARK: - Actions
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    // MARK: - DeInit
    deinit {
         debugPrint(SettingsVC.className + "Release from Momery")
    }
}
