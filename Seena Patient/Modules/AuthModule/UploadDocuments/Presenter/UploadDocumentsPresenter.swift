//
//  UploadDocumentsPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class UploadDocumentsPresenter: UploadDocumentsPresenterProtocol {
    // MARK: - Attributes
    weak var view: UploadDocumentsViewProtocol?
    var interactor: UploadDocumentsInputInteractorProtocol?
    var router: UploadDocumentsRouterProtocol?
    let localization = UploadDocumentsLocalization()
    var documetsType = [DocomentTypeViewModel]()
    var numberOfDocumentsType: Int {
        return documetsType.count
    }
    private var status: Status {
        didSet {
            validateStatus()
        }
    }
    // MARK: - Init
    init(view: UploadDocumentsViewProtocol?, interactor: UploadDocumentsInputInteractorProtocol, router: UploadDocumentsRouterProtocol,
         status: Status) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.status = status
    }
    // MARK: - Methods
    func viewDidLoad() {
        documetsType = [
            DocomentTypeViewModel(name: "ID", isUploaded: status.idType),
            DocomentTypeViewModel(name: "Financial", isUploaded: status.financialProof),
            DocomentTypeViewModel(name: "Residence", isUploaded: status.residenceProof),
            DocomentTypeViewModel(name: "Profile picture", isUploaded: status.profilePicture)
        ]
        view?.setupUI()
        view?.setupDocumentTypeTableView()
    }
    func viewWillAppear() {
    }
    func config(documentTypeCell cell: DocumentTypeCellProtocol, atIndex index: Int) {
        cell.setDocumentType(documetsType[index])
    }
    func documentType(selectedAtIndex index: Int) {
        switch index {
        case 0:
            guard status.idType else {
                router?.go(to: .upload(doucmentTypeIndex: index))
                return
            }
        case 1:
            guard status.financialProof else {
                router?.go(to: .upload(doucmentTypeIndex: index))
                return
            }
        case 2:
            guard status.residenceProof else {
                router?.go(to: .upload(doucmentTypeIndex: index))
                return
            }
        case 3:
            guard status.profilePicture else {
                router?.go(to: .upload(doucmentTypeIndex: index))
                return
            }
        default:
            debugPrint(index)
        }
    }
    func backButtonTapped() {
        router?.go(to: .back)
    }
    func finishButtonTapped() {
        router?.go(to: .finishSignUp)
    }
    func validateStatus() {
        guard status.idType && status.financialProof &&
              status.profilePicture && status.residenceProof else {
            view?.disableFinisButton()
            return
        }
        view?.enableFinishButton()
    }
    func updateStatus(_ status: Status) {
        self.status = status
        documetsType = [
            DocomentTypeViewModel(name: "ID", isUploaded: status.idType),
            DocomentTypeViewModel(name: "Financial", isUploaded: status.financialProof),
            DocomentTypeViewModel(name: "Residence", isUploaded: status.residenceProof),
            DocomentTypeViewModel(name: "Profile picture", isUploaded: status.profilePicture)
        ]
        view?.reloadDocumentsType()
    }
}
// MARK: - UploadDocumentsOutputInteractorProtocol Implementation
extension UploadDocumentsPresenter: UploadDocumentsOutputInteractorProtocol {
}
