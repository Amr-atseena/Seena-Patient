//
//  ATMPayPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ATMPayPresenter: ATMPayPresenterProtocol {
    // MARK: - Attributes
    weak var view: ATMPayViewProtocol?
    var interactor: ATMPayInputInteractorProtocol?
    var router: ATMPayRouterProtocol?
    let localization = ATMPayLocalization()
    // MARK: - Init
    init(view: ATMPayViewProtocol?, interactor: ATMPayInputInteractorProtocol, router: ATMPayRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
    }
}
// MARK: - ATMPayOutputInteractorProtocol Implementation
extension ATMPayPresenter: ATMPayOutputInteractorProtocol {
}
