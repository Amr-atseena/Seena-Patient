//
//  PayVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PayVC: UIViewController, PayViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var paymentKeywordLabel: UILabel!
    @IBOutlet private var bankImage: UIImageView!
    @IBOutlet private var accountNumberKeywordLabel: UILabel!
    @IBOutlet private var accountNumberLabel: UILabel!
    @IBOutlet private var nextButton: UIButton!
    @IBOutlet private var transactionIdTextFiled: UITextField!
    @IBOutlet private var loadingIndicotor: UIActivityIndicatorView!
    // MARK: - Attributes
    var presenter: PayPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: PayVC.className, bundle: nil)
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
        // paymentKeyword Label
        paymentKeywordLabel.text = presenter.localization.payment
        paymentKeywordLabel.font = DesignSystem.Typography.heading.font
        // accountNumberKeyword Label
        accountNumberKeywordLabel.font = DesignSystem.Typography.subHeading3.font
        // accountNumber Label
        accountNumberLabel.font = DesignSystem.Typography.title3.font
        nextButton.setTitle(presenter.localization.next, for: .normal)
        nextButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font
        //  transactionId TextFiled
        transactionIdTextFiled.placeholder = presenter.localization.receiptReference
    }
    func setAccount(image: String, accountName: String, accountNumber: String) {
        bankImage.kf.setImage(with: URL(string: image))
        accountNumberKeywordLabel.text = accountName
        accountNumberLabel.text = accountNumber
    }
    func enableNextButton() {
        nextButton.backgroundColor = DesignSystem.Colors.primaryActionBackground.color
        nextButton.isUserInteractionEnabled = true
    }
    func disableNextButton() {
        nextButton.backgroundColor = DesignSystem.Colors.primaryBorder.color
        nextButton.isUserInteractionEnabled = false
    }
    func showLoadingIndicotor() {
        loadingIndicotor.startAnimating()
    }
    func hideLoadingIndictor() {
        loadingIndicotor.stopAnimating()
    }
    // MARK: - Actions
    @IBAction private func didNextButtonTapped(_ sender: UIButton) {
        presenter.nextButtonTapped(withTransactionId: transactionIdTextFiled.text)
    }
    @IBAction private func didBackButtonTapped(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    @IBAction private func didTranactionTextFieldEditChange(_ sender: UITextField) {
        presenter.transactionIdEditChange(transactionId: sender.text)
    }
    // MARK: - DeInit
    deinit {
         debugPrint(PayVC.className + "Release from Momery")
    }
}
