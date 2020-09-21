//
//  ProfilePresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 29/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    // MARK: - Attributes
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInputInteractorProtocol?
    var router: ProfileRouterProtocol?
    let localization = ProfileLocalization()
    // MARK: - Init
    init(view: ProfileViewProtocol?, interactor: ProfileInputInteractorProtocol, router: ProfileRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
    }
    func viewWillAppear() {
        interactor?.retriveUser()
    }
    func optionButtonTapped(atIndex index: Int) {
        switch index {
        case 0:
            router?.go(to: .transactions)
        case 1:
            router?.go(to: .settings)
        case 2:
            router?.go(to: .share)
        case 3:
            router?.go(to: .share)
        default:
            print(index)
        }
    }
}
// MARK: - ProfileOutputInteractorProtocol Implementation
extension ProfilePresenter: ProfileOutputInteractorProtocol {
    func onRetriveUser(_ user: User?) {
        guard let currentUser = user else {
            router?.go(to: .signIn)
            return
        }
        let username = currentUser.firstName + " " + currentUser.lastName
        view?.updateProfile(userName: username, image: currentUser.image)
    }
}
