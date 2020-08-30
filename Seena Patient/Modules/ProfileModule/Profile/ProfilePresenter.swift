//
//  ProfilePresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 29/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    // MARK: - Attributes
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInputInteractorProtocol?
    var router: ProfileRouterProtocol?
    let localization = ProfileLocalization()
    // MARK: - Init
    init(view: ProfileViewProtocol?, interactor: ProfileInputInteractorProtocol, router: ProfileRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
    }
}
// MARK: - ProfileOutputInteractorProtocol Implementation
extension ProfilePresenter: ProfileOutputInteractorProtocol {
}
