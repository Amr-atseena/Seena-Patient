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
    // MARK: - Init
    init(view: SplashViewProtocol, interactor: SplashInputInteractorProtocol, router: SplashRouter ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.showLoadingIndictor()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view?.hideLoadingIndictor()
            self.router?.go(to: .tabBar)
        }
    }
}
// MARK: - SpalshOutputInteractorProtocol Extenstion
extension SplashPresenter: SplashOutputInteractorProtocol {
}
