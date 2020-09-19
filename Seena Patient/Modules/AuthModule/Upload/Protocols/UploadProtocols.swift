//
//  UploadProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Upload Router
enum UploadRoute {
}
protocol UploadRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: UploadRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - Upload Interactor
protocol UploadInputInteractorProtocol: class {
    var presenter: UploadOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol UploadOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - Upload Preseneter
protocol UploadPresenterProtocol: class {
    var view: UploadViewProtocol? { get set}
    var interactor: UploadInputInteractorProtocol? { get set}
    var router: UploadRouterProtocol? { get set }
    var localization: UploadLocalization { get }
    // view -> Presenter
    func viewDidLoad()
}
// MARK: - Upload View
protocol UploadViewProtocol: class {
    var presenter: UploadPresenterProtocol! { get set }
    // Presenter -> View
}
