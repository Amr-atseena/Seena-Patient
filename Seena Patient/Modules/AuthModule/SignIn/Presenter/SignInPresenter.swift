//
//  SignInPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class SignInPresenter: SignInPresenterProtocol {
    // MARK: - Attributes
    weak var view: SignInViewProtocol?
    var interactor: SignInInputInteractorProtocol?
    var router: SignInRouterProtocol?
    let localization = SignInLocalization()
    // MARK: - Init
    init(view: SignInViewProtocol?, interactor: SignInInputInteractorProtocol, router: SignInRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
    }
    func signInButtonTapped(withPhone phone: String?, andPassword password: String?) {
        view?.showLoadingIndictor()
        interactor?.login(withPhone: phone ?? "", andPassword: password ?? "")
    }
    func signUpButtonTapped() {
        router?.go(to: .signUp)
    }
    func forgotPasswordTapped() {
        router?.go(to: .forgotPassword)
    }
}
// MARK: - SignInOutputInteractorProtocol Implementation
extension SignInPresenter: SignInOutputInteractorProtocol {
    func onLoginSuccess(withStatus status: Status) {
        view?.hideLoadingIndictor()
        if status.financialProof && status.idType &&
            status.profilePicture && status.residenceProof {
               router?.go(to: .profile)
        } else {
            router?.go(to: .signUp)
        }
    }
    func onLoginFail(withMessage message: String) {
        view?.hideLoadingIndictor()
        router?.go(to: .alert(AlertEntity(title: "Error", message: message)))
    }
}
