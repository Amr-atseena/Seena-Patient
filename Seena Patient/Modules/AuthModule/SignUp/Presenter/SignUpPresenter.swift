//
//  SignUpPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class SignUpPresenter: SignUpPresenterProtocol {
    // MARK: - Attributes
    weak var view: SignUpViewProtocol?
    var interactor: SignUpInputInteractorProtocol?
    var router: SignUpRouterProtocol?
    let localization = SignUpLocalization()
    private var idTypes = [Document]()
    private var residenceProof = [Document]()
    private var financialProof = [Document]()
    private var selectedIdType = -1 {
        didSet {
            validatePramaters()
        }
    }
    private var selectedResidenceProof = -1 {
        didSet {
            validatePramaters()
        }
    }
    private var selectedFinancialProof = -1 {
        didSet {
            validatePramaters()
        }
    }
    private var selectedDate = "" {
        didSet {
            validatePramaters()
        }
    }
    private var phoneNumber = "" {
        didSet {
            validatePramaters()
        }
    }
    private var firstName = "" {
        didSet {
            validatePramaters()
        }
    }
    private var lastName = "" {
        didSet {
            validatePramaters()
        }
    }
    private var password = "" {
        didSet {
            validatePramaters()
        }
    }
    private var confirmPassword = "" {
        didSet {
            validatePramaters()
        }
    }
    // MARK: - Init
    init(view: SignUpViewProtocol?, interactor: SignUpInputInteractorProtocol, router: SignUpRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        interactor?.retriveIdTypes()
        interactor?.retriveResidenceProof()
        interactor?.retriveFinancialProof()
    }
    func backButtonTapped() {
        router?.go(to: .signIn)
    }
    func optionsButtonTapped(withIndex index: Int) {
        switch index {
        case 0:
            router?.go(to: .datePiker)
        case 1:
            let names = idTypes.map { $0.value }
            router?.go(to: .optionPicker(options: names, index: index))
        case 2:
            let names = financialProof.map { $0.value }
            router?.go(to: .optionPicker(options: names, index: index))
        case 3:
            let names = residenceProof.map { $0.value }
            router?.go(to: .optionPicker(options: names, index: index))
        default:
            debugPrint(index)
        }
    }
    func optionSelected(atIndex index: Int, forOption option: Int) {
        switch option {
        case 1:
            selectedIdType = idTypes[index].id
            let type = idTypes[index].value
            view?.setIdType(type)
        case 2:
            selectedFinancialProof = financialProof[index].id
            let proof = financialProof[index].value
            view?.setFinancialProof(proof)
        case 3:
            selectedResidenceProof = residenceProof[index].id
            let proof = residenceProof[index].value
            view?.setResidenceProof(proof)
        default:
            debugPrint(index)
        }
    }
    func textChange(_ text: String?, atIndex index: Int) {
        switch index {
        case 0:
            phoneNumber = text ?? ""
        case 1:
            firstName = text ?? ""
        case 2:
            lastName = text ?? ""
        case 3:
            password = text ?? ""
        case 4:
            confirmPassword = text ?? ""
        default:
            debugPrint(index)
        }
    }
    func dateSelected(_ date: Date) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormater.string(from: date)
        view?.setBirthDate(selectedDate)
    }
    func validatePramaters() {
        guard !phoneNumber.isEmpty && !firstName.isEmpty &&
              !lastName.isEmpty    && !confirmPassword.isEmpty &&
              selectedIdType != -1 && selectedResidenceProof != -1 &&
                selectedFinancialProof != -1 && !selectedDate.isEmpty
        else {
            view?.disableFinishButton()
            return
        }
        view?.enableFinishButton()
    }
    func finishButtonTapped() {
        view?.showLoadingIndictor()
        interactor?.signUp(withParam: SignUpRequestParamaters(phone: phoneNumber, firstName: firstName, lastName: lastName, password: password, confirmPassword: confirmPassword, birthdate: selectedDate, idType: selectedIdType, financialProof: selectedFinancialProof, residenceProof: selectedResidenceProof))
    }
}
// MARK: - SignUpOutputInteractorProtocol Implementation
extension SignUpPresenter: SignUpOutputInteractorProtocol {
    func onRetriveIdTypes(_ idTypes: [Document]) {
        self.idTypes = idTypes
    }
    func onRetriveResidenceProof(_ residenceProof: [Document]) {
        self.residenceProof = residenceProof
    }
    func onRetriveFinancialProof(_ financialProof: [Document]) {
        self.financialProof = financialProof
    }
    func onSignUpSuccess() {
        view?.hideLoadingIndicor()
        router?.go(to: .uploadDocuments)
    }
    func onSignUpFail(withError error: String) {
        view?.hideLoadingIndicor()
        router?.go(to: .alert(alertEntity: AlertEntity(title: "Error", message: error)))
    }
}
