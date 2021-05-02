//
//  SignInVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class SignInVC: UIViewController, SignInViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var welcomeKeywordLabel: UILabel!
    @IBOutlet private var signInKeywordLabel: UILabel!
    @IBOutlet private var doNotHaveAccountKeywordLabel: UILabel!
    @IBOutlet private var phoneTextFiled: SkyFloatingLabelTextField!
    @IBOutlet private var passwordTextFiled: SkyFloatingLabelTextField!
    @IBOutlet private var forgotPasswordButton: UIButton!
    @IBOutlet private var signUpButton: UIButton!
    @IBOutlet private var phoneEditingIndictor: UIImageView!
    @IBOutlet private var passwordEditingIndictor: UIImageView!
    @IBOutlet private var loadingIndictor: UIActivityIndicatorView!
    @IBOutlet private var regView: UIView!
    // MARK: - Attributes
    var presenter: SignInPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: SignInVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        regView.isHidden = isInAppleReview
    }
    // MARK: - Methods
    func setupUI() {
        // welcomeKeyword Label
        welcomeKeywordLabel.text = presenter.localization.welcome
        welcomeKeywordLabel.font = DesignSystem.Typography.largeTitle.font
        // signInKeyword Label
        signInKeywordLabel.text = presenter.localization.signIn
        signInKeywordLabel.font = DesignSystem.Typography.subHeading3.font
        // doNotHaveAccountKeyword Label
        doNotHaveAccountKeywordLabel.text = presenter.localization.doNotHaveAccount
        doNotHaveAccountKeywordLabel.font = DesignSystem.Typography.title2.font
        // forgotPassword Button
        forgotPasswordButton.setTitle(presenter.localization.forgotPassword, for: .normal)
        forgotPasswordButton.titleLabel?.font = DesignSystem.Typography.title2.font
        // signUp Button
        signUpButton.setTitle(presenter.localization.signUp, for: .normal)
        signUpButton.titleLabel?.font = DesignSystem.Typography.title2.font
        // phone TextField
        phoneTextFiled.placeholder = presenter.localization.phone
        phoneTextFiled.addTarget(self, action: #selector(didEditingBegin(_:)), for: .editingDidBegin)
        phoneTextFiled.addTarget(self, action: #selector(didEditingEnd(_:)), for: .editingDidEnd)
        // password TextField
        passwordTextFiled.placeholder = presenter.localization.password
        passwordTextFiled.addTarget(self, action: #selector(didEditingBegin(_:)), for: .editingDidBegin)
        passwordTextFiled.addTarget(self, action: #selector(didEditingEnd(_:)), for: .editingDidEnd)
    }
    func showLoadingIndictor() {
        loadingIndictor.startAnimating()
    }
    func hideLoadingIndictor() {
        loadingIndictor.stopAnimating()
    }
    // MARK: - Actions
    @objc private func didEditingBegin(_ sender: UITextField) {
        if sender == phoneTextFiled {
            phoneEditingIndictor.isHidden = false
        } else {
            passwordEditingIndictor.isHidden = false
        }
    }
    @objc private func didEditingEnd(_ sender: UITextField) {
        if sender == phoneTextFiled {
            phoneEditingIndictor.isHidden = true
        } else {
            passwordEditingIndictor.isHidden = true
        }
    }
    @IBAction private func didSignInButtonTapped(_ sender: UIButton) {
        presenter.signInButtonTapped(withPhone: phoneTextFiled.text, andPassword: passwordTextFiled.text)
    }
    @IBAction private func didSignUpButtonTapped(_ sender: UIButton) {
        presenter.signUpButtonTapped()
    }
    @IBAction private func didForgotPasswordButtonTapped(_ sender: UIButton) {
        presenter.forgotPasswordTapped()
    }
    // MARK: - DeInit
    deinit {
         debugPrint(SignInVC.className + " Release from Momery")
    }
}
