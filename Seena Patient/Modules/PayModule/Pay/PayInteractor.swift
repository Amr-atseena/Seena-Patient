//
//  PayInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class PayInteractor: PayInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: PayOutputInteractorProtocol?
    var localDataManager: PaymentLocalDataManagerProtocol
    var remoteDataManager: PaymentRemoteDataManagerProtocol
    init(localDataManager: PaymentLocalDataManagerProtocol, remoteDataManager: PaymentRemoteDataManagerProtocol) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func payInstallment(_ payemnt: Payment) {
        remoteDataManager.payInstallment(token: localDataManager.retriveToken(), payment: payemnt) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                guard let responseData = data as? BaseResponse<Response>, responseData.serverResonse.code == 200 else {
                    let response = data as? BaseResponse<Response>
                    self.presenter?.onRetriveDataFail(withError: response?.serverResonse.desc ?? "")
                    return
                }
                self.presenter?.onRetriveDataSuccess()
            case .failure(let error):
                self.presenter?.onRetriveDataFail(withError: error.localizedDescription)
            }
        }
    }
}
