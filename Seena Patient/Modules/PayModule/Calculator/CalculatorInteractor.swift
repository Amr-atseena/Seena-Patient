//
//  CalculatorInteractor.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class CalculatorInteractor: CalculatorInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: CalculatorOutputInteractorProtocol?
    var localDataManager: PaymentLocalDataManagerProtocol
    // MARK: - Init
    init(localDataManager: PaymentLocalDataManagerProtocol) {
        self.localDataManager = localDataManager
    }
    // MARK: - Methods
    func retrivePlans() {
        presenter?.onRetrivePlansSuccess(localDataManager.retrivePlans())
    }
}
