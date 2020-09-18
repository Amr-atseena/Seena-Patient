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
}
protocol UploadDocumentsRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: UploadDocumentsRoute)
    static func assembleModule() -> UIViewController
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
}
// MARK: - UploadDocuments View
protocol UploadDocumentsViewProtocol: class {
    var presenter: UploadDocumentsPresenterProtocol! { get set }
    // Presenter -> View
}
