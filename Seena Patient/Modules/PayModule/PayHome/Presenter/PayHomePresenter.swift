//
//  PayHomePresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 06/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class PayHomePresenter: PayHomePresenterProtocol {
    // MARK: - Attributes
    weak var view: PayHomeViewProtocol?
    var interactor: PayHomeInputInteractorProtocol?
    var router: PayHomeRouterProtocol?
    let localization = PayHomeLocalization()
    // MARK: - Init
    init(view: PayHomeViewProtocol?, interactor: PayHomeInputInteractorProtocol, router: PayHomeRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
    }
}
// MARK: - PayHomeOutputInteractorProtocol Implementation
extension PayHomePresenter: PayHomeOutputInteractorProtocol {
}
