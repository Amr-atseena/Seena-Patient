//
//  UploadDocumentsPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class UploadDocumentsPresenter: UploadDocumentsPresenterProtocol {
    // MARK: - Attributes
    weak var view: UploadDocumentsViewProtocol?
    var interactor: UploadDocumentsInputInteractorProtocol?
    var router: UploadDocumentsRouterProtocol?
    let localization = UploadDocumentsLocalization()
    // MARK: - Init
    init(view: UploadDocumentsViewProtocol?, interactor: UploadDocumentsInputInteractorProtocol, router: UploadDocumentsRouterProtocol,
         status: Status) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
    }
}
// MARK: - UploadDocumentsOutputInteractorProtocol Implementation
extension UploadDocumentsPresenter: UploadDocumentsOutputInteractorProtocol {
}
