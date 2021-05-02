//
//  PaymentSuccessVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PaymentSuccessVC: UIViewController, PaymentSuccessViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var bankImage: UIImageView!
    @IBOutlet private var accountNumberKeywordLabel: UILabel!
    @IBOutlet private var accountNumberLabel: UILabel!
    @IBOutlet private var doneButton: UIButton!
    @IBOutlet private var paymentSuccessKeywordLabel: UILabel!
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var paymentBodyKeywordLabel: UILabel!
    // MARK: - Attributes
    var presenter: PaymentSuccessPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: PaymentSuccessVC.className, bundle: nil)
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
        // accountNumberKeyword Label
        accountNumberKeywordLabel.font = DesignSystem.Typography.subHeading3.font
        accountNumberKeywordLabel.text = presenter.localization.accountNumber
        // accountNumber Label
        accountNumberLabel.font = DesignSystem.Typography.title3.font
        // done Button
        doneButton.setTitle(presenter.localization.done, for: .normal)
        doneButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font
        // paymentSuccessKeyword Label
        paymentSuccessKeywordLabel.text = presenter.localization.paymentSuccess
        paymentSuccessKeywordLabel.font = DesignSystem.Typography.heading.font
        // amount Label
        amountLabel.font = DesignSystem.Typography.heading.font
        // paymentBodyKeyword Label
        paymentBodyKeywordLabel.text = presenter.localization.paymentBody
        paymentBodyKeywordLabel.font = DesignSystem.Typography.title3.font
    }
    func setAccount(image: String, accountName: String, accountNumber: String, amount: String) {
        bankImage.kf.setImage(with: URL(string: image))
        accountNumberKeywordLabel.text = accountName
        accountNumberLabel.text = accountNumber
        amountLabel.text = amount
    }
    // MARK: - Actions
    @IBAction private func didDoneButtonTapped(_ sender: UIButton) {
        presenter.doneButtonTapped()
    }
    // MARK: - DeInit
    deinit {
         debugPrint(PaymentSuccessVC.className + "Release from Momery")
    }
}
