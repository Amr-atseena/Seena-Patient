//
//  PayPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class PayPresenter: PayPresenterProtocol {
    // MARK: - Attributes
    weak var view: PayViewProtocol?
    var interactor: PayInputInteractorProtocol?
    var router: PayRouterProtocol?
    let localization = PayLocalization()
    // MARK: - Init
    init(view: PayViewProtocol?, interactor: PayInputInteractorProtocol, router: PayRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
    }
}
// MARK: - PayOutputInteractorProtocol Implementation
extension PayPresenter: PayOutputInteractorProtocol {
}
