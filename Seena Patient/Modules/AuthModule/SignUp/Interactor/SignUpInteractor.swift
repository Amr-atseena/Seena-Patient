//
//  SignUpInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class SignUpInteractor: SignUpInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: SignUpOutputInteractorProtocol?
    var localDataManager: SignUpLocalDataManagerProtocol
    // MARK: - Init
    init(localDataManager: SignUpLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
    }
    // MARK: - Methods
    func retriveIdTypes() {
        presenter?.onRetriveIdTypes(localDataManager.retrivDocumets(forKey: .id))
    }
    func retriveResidenceProof() {
        presenter?.onRetriveResidenceProof(localDataManager.retrivDocumets(forKey: .residence))
    }
    func retriveFinancialProof() {
        presenter?.onRetriveFinancialProof(localDataManager.retrivDocumets(forKey: .financial))
    }
}
