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
        let interactor = SignUpInteractor(localDataManager: localDataManager)
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
        case .datePiker:
            showDatePicker()
        case .optionPicker(let options, let index):
            showOptionsPicker(options: options, index: index)
        }
    }
    private func navigateToSignIn() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    private func showDatePicker() {
        let alert = UIAlertController(title: "Choose", message: "Please Choose Your Date", preferredStyle: .actionSheet)
        guard let signUp = viewController as? SignUpViewProtocol else { return }
        var selectedDate = Date()
        alert.addDatePicker(mode: .date, date: Date()) { (date) in
            selectedDate = date
        }
        let doneAlert = UIAlertAction(title: "Done", style: .cancel) { (_) in
            signUp.presenter.dateSelected(selectedDate)
        }
        alert.addAction(doneAlert)
        viewController?.present(alert, animated: true)
    }
    private func showOptionsPicker(options: [String], index: Int) {
        let alert = UIAlertController(title: "Choose", message: "Please Choose Your Birthdate", preferredStyle: .actionSheet)
        guard let signUp = viewController as? SignUpViewProtocol else { return }
        let documentOptionIndex = index
        var selectedIndex = 0
        alert.addPickerView(values: [options]) { (_, _, index, _) in
            selectedIndex = index.row
        }
        let doneAlert = UIAlertAction(title: "Done", style: .cancel) { (_) in
            signUp.presenter.optionSelected(atIndex: selectedIndex, forOption: documentOptionIndex)
        }
        alert.addAction(doneAlert)
        viewController?.present(alert, animated: true)
    }
}
