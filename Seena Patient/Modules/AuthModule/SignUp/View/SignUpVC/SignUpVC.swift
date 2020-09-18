//
//  SignUpVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, SignUpViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var phoneTextField: UITextField!
    @IBOutlet private var firstNameTextFiled: UITextField!
    @IBOutlet private var lastNameTextFiled: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var confirmPasswordTextField: UITextField!
    @IBOutlet private var birthdateTextFiled: UITextField!
    @IBOutlet private var idTypeTextFiled: UITextField!
    @IBOutlet private var financialProofTypeTextField: UITextField!
    @IBOutlet private var residentProofTypeTextFiled: UITextField!
    @IBOutlet private var loadingIndictor: UIActivityIndicatorView!
    @IBOutlet private var finishButton: UIButton!
    // MARK: - Attributes
    var presenter: SignUpPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: SignUpVC.className, bundle: nil)
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
        // phone TextField
        phoneTextField.placeholder = presenter.localization.phone
        // firstName TextField
        firstNameTextFiled.placeholder = presenter.localization.firstName
        // lastName TextField
        lastNameTextFiled.placeholder = presenter.localization.lastName
        // password TextField
        passwordTextField.placeholder = presenter.localization.password
        // confirmPassword TextField
        confirmPasswordTextField.placeholder = presenter.localization.confirmPassword
        // birthdate TextField
        birthdateTextFiled.placeholder = presenter.localization.birthdate
        // idType TextField
        idTypeTextFiled.placeholder = presenter.localization.idType
        // financialProofType TextField
        financialProofTypeTextField.placeholder = presenter.localization.financialProofType
        // ReresidentProofType TextField
        residentProofTypeTextFiled.placeholder = presenter.localization.residenceProofType
        finishButton.setTitle(presenter.localization.finish, for: .normal)
        finishButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font
    }
    func setIdType(_ type: String) {
        idTypeTextFiled.text = type
    }
    func setFinancialProof(_ proof: String) {
        financialProofTypeTextField.text = proof
    }
    func setResidenceProof(_ proof: String) {
        residentProofTypeTextFiled.text = proof
    }
    func setBirthDate(_ date: String) {
        birthdateTextFiled.text = date
    }
    // MARK: - Actions
    @IBAction private func didTapFinishButton(_ sender: UIButton) {
    }
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    @IBAction private func didTapOptionsButton(_ sender: UIButton) {
        presenter.optionsButtonTapped(withIndex: sender.tag)
    }
    // MARK: - DeInit
    deinit {
        debugPrint(SignUpVC.className + "Release from Momery")
    }
}
