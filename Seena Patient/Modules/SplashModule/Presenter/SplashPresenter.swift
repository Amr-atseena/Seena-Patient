//
//  SplashPresenter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class SplashPresenter: SplashPresenterProtocol {
    // MARK: - Attributes
    var router: SplashRouterProtocol?
    var interactor: SplashInputInteractorProtocol?
    weak var view: SplashViewProtocol?
    let serial: String
    var token: String
    // MARK: - Init
    init(view: SplashViewProtocol, interactor: SplashInputInteractorProtocol, router: SplashRouter, serial: String, token: String ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.serial = serial
        self.token = token
    }
    // MARK: - Methods
    func viewDidLoad() {
        retriveMetaData()
        interactor?.sendToken(serial: serial, token: token)
    }
    func retriveMetaData() {
        view?.showLoadingIndictor()
        interactor?.retriveMetaData()
    }
}
// MARK: - SpalshOutputInteractorProtocol Extenstion
extension SplashPresenter: SplashOutputInteractorProtocol {
    func onRetriveMetaDataSuccess() {
        view?.hideLoadingIndictor()
        router?.go(to: .tabBar)
    }
    func onRetriveDataFail(_ error: String) {
        view?.hideLoadingIndictor()
        router?.go(to: .alert(alertEntity: AlertEntity(title: "Error", message: error)))
    }
}
