//
//  SignUpPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class SignUpPresenter: SignUpPresenterProtocol {
    // MARK: - Attributes
    weak var view: SignUpViewProtocol?
    var interactor: SignUpInputInteractorProtocol?
    var router: SignUpRouterProtocol?
    let localization = SignUpLocalization()
    // MARK: - Init
    init(view: SignUpViewProtocol?, interactor: SignUpInputInteractorProtocol, router: SignUpRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
    }
    func backButtonTapped() {
        router?.go(to: .signIn)
    }
}
// MARK: - SignUpOutputInteractorProtocol Implementation
extension SignUpPresenter: SignUpOutputInteractorProtocol {
}
