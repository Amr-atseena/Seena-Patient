//
//  ClinicsHomeInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ClinicsHomeInteractor: ClinicsHomeInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: ClinicsHomeOutputInteractorProtocol?
    var remoteDataManager: ClinicsRemoteDataManangerProtocol
    // MARK: - Init
    init(remoteDataManager: ClinicsRemoteDataManangerProtocol) {
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func retriveClinicsHome() {
        remoteDataManager.retriveClinicsHome { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.presenter?.onRetriveClincsHomeFail()
            case .success(let response):
                guard let response = response as? BaseResponse<ClinicsHomeResponse>, response.serverResonse.code == 200,
                    let specialities = response.response?.specialities
                else {
                    self.presenter?.onRetriveClincsHomeFail()
                    return
                }
                self.presenter?.onRetriveClinicsHomeSuccess(specialities: specialities, clinicOfTheWeek: response.response?.clinicOfWeek)
            }
        }
    }
}
