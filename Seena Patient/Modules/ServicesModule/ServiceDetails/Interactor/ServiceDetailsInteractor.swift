//
//  ServiceDetailsInteractor.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/16/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ServiceDetailsInteractor: ServiceDetailsInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: ServiceDetailsOutputInteractorProtocol?
    private let remoteDataManager: ServicesRemoteDataManagerProtocol?
    // MARK: - Init
    init(remoteDataManager: ServicesRemoteDataManagerProtocol) {
        self.remoteDataManager = remoteDataManager
    }
    // MARK: - Methods
    func retriveServiceDetails(atServiceId serviceId: Int) {
        remoteDataManager?.retriveServicesDetails(atServiceId: serviceId, completionHandler: { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                guard let response = response as? BaseResponse<Service>, response.serverResonse.code == 200 else {
                    self.presenter?.onRetriveDataFail()
                    return
                }
                self.presenter?.onRetriveDataSuccess(withService: response.response!)
            case .failure:
                self.presenter?.onRetriveDataFail()
            }
        })
    }
}
