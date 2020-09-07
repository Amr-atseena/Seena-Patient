//
//  PaymentChannelPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 07/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class PaymentChannelPresenter: PaymentChannelPresenterProtocol {
    // MARK: - Attributes
    weak var view: PaymentChannelViewProtocol?
    var interactor: PaymentChannelInputInteractorProtocol?
    var router: PaymentChannelRouterProtocol?
    let localization = PaymentChannelLocalization()
    // MARK: - Init
    init(view: PaymentChannelViewProtocol?, interactor: PaymentChannelInputInteractorProtocol, router: PaymentChannelRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
    }
}
// MARK: - PaymentChannelOutputInteractorProtocol Implementation
extension PaymentChannelPresenter: PaymentChannelOutputInteractorProtocol {
}
