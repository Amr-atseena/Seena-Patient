//
//  ProfileInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 29/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ProfileInteractor: ProfileInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: ProfileOutputInteractorProtocol?
    var localDataManager: ProfileLocalDataManagerProtocol
    // MARK: - Init
    init(localDataManager: ProfileLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
    }
    // MARK: - Methods
    func retriveUser() {
        presenter?.onRetriveUser(localDataManager.retriveUser())
    }
}
