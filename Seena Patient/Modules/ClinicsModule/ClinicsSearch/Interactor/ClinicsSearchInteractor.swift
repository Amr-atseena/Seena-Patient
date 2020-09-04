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
    var remoteDataManager: ClinicsRemoteDataManangerProtocol
    // MARK: - Init
    init(localDataManager: ClinicsSearchLocalDataManagerProtocol,
         remoteDataManager: ClinicsRemoteDataManangerProtocol) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func retriveCities() {
        let cities = localDataManager.retriveCities()
        presenter?.onRetriveCities(cities)
    }
    func retriveClinicsList(withParameters parms: ClinicsListParameters) {
        remoteDataManager.retriveClinicsList(parms: parms) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.presenter?.onRetriveClinicsListFail()
            case .success(let response):
                guard let response = response as? BaseResponse<[Clinic]>, response.serverResonse.code == 200, let clinics = response.response else {
                    self.presenter?.onRetriveClinicsListFail()
                    return
                }
                self.presenter?.onRetriveClinicsListSuccess(clinics)
            }
        }
    }
}
