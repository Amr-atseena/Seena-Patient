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
            router?.go(to: .alert(AlertEntity(title: "", message: "LogoutMessage".localized)))
        case 4:
            print("Profile")
            router?.go(to: .applicationStatus)
        default:
            print(index)
        }
    }
    func logOut() {
        interactor?.removeUser()
        router?.go(to: .signIn)
    }
}
// MARK: - ProfileOutputInteractorProtocol Implementation
extension ProfilePresenter: ProfileOutputInteractorProtocol {
    func onRetriveUser(_ user: User?) {
        guard let currentUser = user else {
            router?.go(to: .signIn)
            print("Hna")
            return
        }
        let username = currentUser.firstName + " " + currentUser.lastName
        view?.updateProfile(userName: username, image: currentUser.image)
        interactor?.retriveApplicationStatus()
    }
    func onRetrieApplicationStatusSuccess(_ status: String) {
        switch status {
        case "pending":
            view?.setApplicationStatus(status: "pending".toLocalize, color: DesignSystem.Colors.pending.color)
        case "قيد الأنتظار":
            view?.setApplicationStatus(status: "pending".toLocalize, color: DesignSystem.Colors.pending.color)
        case "activate":
            view?.setApplicationStatus(status: "activate".localized, color: DesignSystem.Colors.accept.color)
        case "فعال":
            view?.setApplicationStatus(status: "activate".localized, color: DesignSystem.Colors.accept.color)
        case "rejected":
            view?.setApplicationStatus(status: "rejected".localized, color: DesignSystem.Colors.primaryActionBackground.color)
        case "مرفوض":
            view?.setApplicationStatus(status: "rejected".localized, color: DesignSystem.Colors.primaryActionBackground.color)
        case "missing info":
            view?.setApplicationStatus(status: "missing info".localized, color: DesignSystem.Colors.primaryActionBackground.color)
        case "فاقد معلومات":
            view?.setApplicationStatus(status: "missing info".localized, color: DesignSystem.Colors.primaryActionBackground.color)
        default:
//            view?.setApplicationStatus(status: status, color: DesignSystem.Colors.primaryActionBackground.color)
            view?.setApplicationStatus(status: status, color: .clear)
        }
    }
    func onRetriveApplicationStatusFail() {
        view?.hideApplicationStatus()
    }
}
