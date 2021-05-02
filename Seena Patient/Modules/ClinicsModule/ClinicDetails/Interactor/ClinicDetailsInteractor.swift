//
//  ClinicDetailsInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ClinicDetailsInteractor: ClinicDetailsInputInteractorProtocol {
    // MARK: - Attributes
    var remoteDataManager: ClinicsRemoteDataManangerProtocol
    weak var presenter: ClinicDetailsOutputInteractorProtocol?
    // MARK: - Init
    init(remoteDataManager: ClinicsRemoteDataManangerProtocol) {
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func retriveClinicDetails(atClinicId clinicId: Int) {
        remoteDataManager.retriveClinicDetails(atClinicId: clinicId) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.presenter?.onRetriveDataFail()
            case .success(let response):
                guard let response = response as? BaseResponse<Clinic>, let clinic = response.response, response.serverResonse.code == 200 else {
                    self.presenter?.onRetriveDataFail()
                    return
                }
                self.presenter?.onRetriveClinicSuccess(clinic)
            }
        }
    }
}
