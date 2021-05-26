//
//  ATMPayInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ATMPayInteractor: ATMPayInputInteractorProtocol {


    // MARK: - Attributes
    weak var presenter: ATMPayOutputInteractorProtocol?
    var localDataManager: PaymentLocalDataManagerProtocol
    // MARK: - Init
    init(localDataManager: PaymentLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
    }
    // MARK: - Methods
    func retriveBanksAccount() {
        presenter?.onRetriveBanksAccountSuccess(localDataManager.retriveBackAccount())
    }
    func retriveVodafoneAccount() {
        presenter?.onRetriveVodafoneAccountSuccess(localDataManager.retriveVodafoneAccount())
    }

    func retriveSeena() {
        presenter?.onRetriveSeena()
    }


//    func retriveEtisalatAccount() {
//        presenter?.onRetriveEtisalatAccountSuccess(localDataManager.retriveEtisalatAccount())
//    }

}
