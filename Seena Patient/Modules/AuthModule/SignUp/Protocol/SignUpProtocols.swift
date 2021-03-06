//
//  SignUpProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - SignUp Router
enum SignUpRoute {
    case signIn
    case datePiker
    case optionPicker(options: [String], index: Int)
    case alert(alertEntity: AlertEntity)
    case uploadDocuments(Status)
    case documents
}
protocol SignUpRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: SignUpRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - SignUp Interactor
protocol SignUpInputInteractorProtocol: class {
    var presenter: SignUpOutputInteractorProtocol? { get set }
    var localDataManager: SignUpLocalDataManagerProtocol { get set }
    var remoteDataManager: AuthenticationRemoteDataManagerProtocol { get set }
    // Presenter -> Interactor
    func retriveIdTypes()
    func retriveResidenceProof()
    func retriveFinancialProof()
    func signUp(withParam param: SignUpRequestParamaters)
}
protocol SignUpOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveIdTypes(_ idTypes: [Document])
    func onRetriveResidenceProof(_ residenceProof: [Document])
    func onRetriveFinancialProof(_ financialProof: [Document])
    func onSignUpSuccess(withStatus status: Status)
    func onSignUpFail(withError error: String)
}
// MARK: - SignUp Preseneter
protocol SignUpPresenterProtocol: class {
    var view: SignUpViewProtocol? { get set}
    var interactor: SignUpInputInteractorProtocol? { get set}
    var router: SignUpRouterProtocol? { get set }
    var localization: SignUpLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func backButtonTapped()
    func optionsButtonTapped(withIndex index: Int)
    func optionSelected(atIndex index: Int, forOption option: Int)
    func dateSelected(_ date: Date)
    func textChange(_ text: String?, atIndex index: Int)
    func validatePramaters()
    func finishButtonTapped()
}
// MARK: - SignUp View
protocol SignUpViewProtocol: class {
    var presenter: SignUpPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setIdType(_ type: String)
    func setFinancialProof(_ proof: String)
    func setResidenceProof(_ proof: String)
    func setBirthDate(_ date: String)
    func enableFinishButton()
    func disableFinishButton()
    func showLoadingIndictor()
    func hideLoadingIndicor()
}
