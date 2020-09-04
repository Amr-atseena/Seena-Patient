//
//  ClinicsSearchInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ClinicsSearchInteractor: ClinicsSearchInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: ClinicsSearchOutputInteractorProtocol?
    var localDataManager: ClinicsSearchLocalDataManagerProtocol
    // MARK: - Init
    init(localDataManager: ClinicsSearchLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
    }
    // MARK: - Methods
    func retriveCities() {
        let cities = localDataManager.retriveCities()
        presenter?.onRetriveCities(cities)
    }
}
