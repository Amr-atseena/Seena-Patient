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
    }
    func signUpButtonTapped() {
    }
    func forgotPasswordTapped() {
    }
}
// MARK: - SignInOutputInteractorProtocol Implementation
extension SignInPresenter: SignInOutputInteractorProtocol {
}
