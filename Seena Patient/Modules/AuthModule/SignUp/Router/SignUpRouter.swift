//
//  SignUpRouter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
class SignUpRouter: SignUpRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let router = SignUpRouter()
        let localDataManager = SignUpLocalDataManager()
        let remoteDataManager = AuthenticationRemoteDataManager()
        let interactor = SignUpInteractor(localDataManager: localDataManager,remoteDataManager: remoteDataManager)
        let view = SignUpVC()
        let presenter = SignUpPresenter(view: view, interactor: interactor, router: router)
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    // MARK: - Routing
    func go(to router: SignUpRoute) {
        switch router {
        case .signIn:
            navigateToSignIn()
        case .uploadDocuments(let status):
            navigateToUploadDocumets(withStatus: status)
        case .datePiker:
            showDatePicker()
        case .optionPicker(let options, let index):
            showOptionsPicker(options: options, index: index)
        case .alert(let alertEntity):
            showAlert(alertEntity: alertEntity)

        case .documents:
//            navigateToDocumets()
        print("AAA")

        }
    }
    private func navigateToSignIn() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    private func showDatePicker() {
        let alert = UIAlertController(title: "Choose".localized, message: "", preferredStyle: .actionSheet)
        guard let signUp = viewController as? SignUpViewProtocol else { return }
        var selectedDate = Date()
        alert.addDatePicker(mode: .date, date: Date()) { (date) in
            selectedDate = date
        }
        let doneAlert = UIAlertAction(title: "Done".localized, style: .cancel) { (_) in
            signUp.presenter.dateSelected(selectedDate)
        }
        alert.addAction(doneAlert)
        viewController?.present(alert, animated: true)
    }
    private func showOptionsPicker(options: [String], index: Int) {
        let alert = UIAlertController(title: "Choose".localized, message: "", preferredStyle: .actionSheet)
        guard let signUp = viewController as? SignUpViewProtocol else { return }
        let documentOptionIndex = index
        var selectedIndex = 0
        alert.addPickerView(values: [options]) { (_, _, index, _) in
            selectedIndex = index.row
        }
        let doneAlert = UIAlertAction(title: "Done".localized, style: .cancel) { (_) in
            signUp.presenter.optionSelected(atIndex: selectedIndex, forOption: documentOptionIndex)
        }
        alert.addAction(doneAlert)
        viewController?.present(alert, animated: true)
    }
    private func navigateToUploadDocumets(withStatus status: Status) {
        let uploadDocuments = UploadDocumentsRouter.assembleModule(withStatus: status)
        viewController?.navigationController?.pushViewController(uploadDocuments, animated: true)
    }

//    private func navigateToDocumets() {
//        let uploadDocuments = UploadDocumentsRouter.assembleModule
//        viewController?.navigationController?.pushViewController(uploadDocuments, animated: true)
//    }
    private func showAlert(alertEntity: AlertEntity) {
        let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
        viewController?.showAlertController(title: alertEntity.title, message: alertEntity.message, actions: [okAction])
    }
}
