//
//  PayHomeInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 06/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class PayHomeInteractor: PayHomeInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: PayHomeOutputInteractorProtocol?
    var localDataManager: PaymentLocalDataManagerProtocol
    var remoteDataManager: PaymentRemoteDataManagerProtocol
    // MARK: - Init
    init(localDataManager: PaymentLocalDataManagerProtocol, remoteDataManager: PaymentRemoteDataManagerProtocol) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func retriveUser() {
        presenter?.onRetriveUserSuccess(localDataManager.retriveUser())
    }
    func retrivePaymentDue() {
        remoteDataManager.retrivePayment(token: localDataManager.retriveToken()) { [weak self] (result) in 
            guard let self = self else { return }
            switch result {
            case .failure:
                self.presenter?.onRetrivePaymentFail()
            case .success(let data):
                guard let data = data as? BaseResponse<PaymentHomeResponse>, data.serverResonse.code == 200, let payment = data.response else {
                    self.presenter?.onRetrivePaymentFail()
                    return
                }
                self.presenter?.onRetrivePaymentSuccess(payment)
            }
        }
    }
}
