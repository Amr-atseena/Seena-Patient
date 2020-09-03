//
//  ServicesSearchInteractor.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/17/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ServicesSearchInteractor: ServicesSearchInputInteractorProtocol {
    // MARK: - Attributes
    weak var presenter: ServicesSearchOutputInteractorProtocol?
    var remoteDataServices: ServicesRemoteDataManager?
    // MARK: - Init
    init(remoteDataServices: ServicesRemoteDataManager) {
        self.remoteDataServices = remoteDataServices
    }
    // MARK: - Methods
    func fetchServicesList(forKeyword keyword: String, atPage page: Int) {
        remoteDataServices?.fetchServicesList(parms: ServicesListParameters(searchKeyword: keyword, currentPage: page), completionHandler: { [weak self] (results) in
            guard let self = self else { return }
            switch results {
            case .failure:
                self.presenter?.onRetriveDataFail()
            case .success(let response):
                guard let response = response as? BaseResponse<[Service]>, let services = response.response, response.serverResonse.code == 200 else {
                    self.presenter?.onRetriveDataFail()
                    return
                }
                self.presenter?.onRetriveDataSuccess(withServices: services)

            }
        })
    }
}
