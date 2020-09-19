//
//  UploadPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class UploadPresenter: UploadPresenterProtocol {
    // MARK: - Attributes
    weak var view: UploadViewProtocol?
    var interactor: UploadInputInteractorProtocol?
    var router: UploadRouterProtocol?
    let localization = UploadLocalization()
    // MARK: - Init
    init(view: UploadViewProtocol?, interactor: UploadInputInteractorProtocol, router: UploadRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
    }
}
// MARK: - UploadOutputInteractorProtocol Implementation
extension UploadPresenter: UploadOutputInteractorProtocol {
}
