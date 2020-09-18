//
//  UploadDocumentsProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - UploadDocuments Router
enum UploadDocumentsRoute {
    case back
    case upload(doucmentTypeIndex: Int)
    case finishSignUp
}
protocol UploadDocumentsRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: UploadDocumentsRoute)
    static func assembleModule(withStatus status: Status) -> UIViewController
}
// MARK: - UploadDocuments Interactor
protocol UploadDocumentsInputInteractorProtocol: class {
    var presenter: UploadDocumentsOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol UploadDocumentsOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - UploadDocuments Preseneter
protocol UploadDocumentsPresenterProtocol: class {
    var view: UploadDocumentsViewProtocol? { get set}
    var interactor: UploadDocumentsInputInteractorProtocol? { get set}
    var router: UploadDocumentsRouterProtocol? { get set }
    var localization: UploadDocumentsLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func viewWillAppear()
    func config(documentTypeCell cell: DocumentTypeCellProtocol, atIndex index: Int)
    func documentType(selectedAtIndex index: Int)
    func backButtonTapped()
    func finishButtonTapped()
    func validateStatus()
    var numberOfDocumentsType: Int { get }
}
// MARK: - UploadDocuments View
protocol UploadDocumentsViewProtocol: class {
    var presenter: UploadDocumentsPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setupDocumentTypeTableView()
    func reloadDocumentsType()
    func enableFinishButton()
    func disableFinisButton()
}

// MARK: - DocumentTypeCellProtocol
protocol DocumentTypeCellProtocol: class {
    func setDocumentType(_ type: DocomentTypeViewModel)
}
