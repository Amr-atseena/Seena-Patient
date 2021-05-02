//
//  UploadPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

class UploadPresenter: UploadPresenterProtocol {
    // MARK: - Attributes
    weak var view: UploadViewProtocol?
    var interactor: UploadInputInteractorProtocol?
    var router: UploadRouterProtocol?
    let localization = UploadLocalization()
    private let documentType: Int
    var selectedImages = [Data]() {
        didSet {
            view?.reoladImages()
            if selectedImages.isEmpty {
                view?.disableFinishButton()
            } else {
                view?.enableFinishButton()
            }
        }
    }
    var numberOfImages: Int {
        return selectedImages.count
    }
    // MARK: - Init
    init(view: UploadViewProtocol?,
         interactor: UploadInputInteractorProtocol,
         router: UploadRouterProtocol,
         documentType: Int) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.documentType = documentType
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
        view?.setupImagesCollectionView()
    }
    func backButtonTapped() {
        router?.go(to: .back(nil))
    }
    func uploadButtonTapped() {
        view?.openImagePicker()
    }
    func finishButtonTapped() {
        view?.showLoadingIndictor()
        interactor?.upload(images: selectedImages, forType: documentType)
    }
    func imageSelected(_ image: Data?) {
        guard let selectedImage = image  else {
            return
        }
        selectedImages.append(selectedImage)
    }
    func config(UploadImageCell cell: UploadImageCellProtocol, atIndex index: Int) {
        let image = selectedImages[index]
        cell.setImage(image)
    }
    func deleteImageButtonTapped(atIndex index: Int) {
        selectedImages.remove(at: index)
    }
}
// MARK: - UploadOutputInteractorProtocol Implementation
extension UploadPresenter: UploadOutputInteractorProtocol {
    func onUploadImagesSuccess(withStatus status: Status) {
        view?.hideLoadingIndictor()
        router?.go(to: .back(status))
    }
    func onUploadImagesFail(withError error: String) {
        view?.hideLoadingIndictor()
        router?.go(to: .alert(AlertEntity(title: "Error", message: error)))
    }
}
