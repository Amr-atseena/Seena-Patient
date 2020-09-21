//
//  SettingsPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class SettingsPresenter: SettingsPresenterProtocol {
    // MARK: - Attributes
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInputInteractorProtocol?
    var router: SettingsRouterProtocol?
    let localization = SettingsLocalization()
    // MARK: - Init
    init(view: SettingsViewProtocol?, interactor: SettingsInputInteractorProtocol, router: SettingsRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
    }
}
// MARK: - SettingsOutputInteractorProtocol Implementation
extension SettingsPresenter: SettingsOutputInteractorProtocol {
}
