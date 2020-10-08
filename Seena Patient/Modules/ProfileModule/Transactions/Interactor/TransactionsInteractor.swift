//
//  TransactionsInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class TransactionsInteractor: TransactionsInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: TransactionsOutputInteractorProtocol?
    var remoteDataManager: PaymentRemoteDataManagerProtocol
    var localDataManager: TokenLocalDataManagerProtocol
    // MARK: - Init
    init(localDataManager: TokenLocalDataManagerProtocol ,remoteDataManager: PaymentRemoteDataManagerProtocol) {
        self.remoteDataManager = remoteDataManager
        self.localDataManager = localDataManager
    }
    // MARK: - Methods
    func retriveTransactions() {
        remoteDataManager.retriveTransactions(token: localDataManager.retriveToken()) { [weak self] (results) in
            guard let self = self else {return}
            switch results {
            case .failure:
                self.presenter?.onRetriveTransactionsFail()
            case .success(let data):
                guard let data = data as? ServerResonse, data.code == 200 else {
                    self.presenter?.onRetriveTransactionsFail()
                    return
                }
                self.presenter?.onRetriveTransactionsSuccess()
            }
        }
    }
}
