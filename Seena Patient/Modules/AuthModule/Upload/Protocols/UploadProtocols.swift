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
    case back
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
    func backButtonTapped()
    func uploadButtonTapped()
    func finishButtonTapped()
    func imageSelected(_ image: Data?)
    func config(UploadImageCell cell: UploadImageCellProtocol, atIndex index: Int)
    func deleteImageButtonTapped(atIndex index: Int)
    var numberOfImages: Int { get }
}
// MARK: - Upload View
protocol UploadViewProtocol: class {
    var presenter: UploadPresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func setupImagesCollectionView()
    func openImagePicker()
    func showLoadingIndictor()
    func hideLoadingIndictor()
    func enableFinishButton()
    func disableFinishButton()
    func reoladImages()
}
// MARK: - UploadImageCell Protocol
protocol  UploadImageCellProtocol {
    func setImage(_ image: Data)
}
