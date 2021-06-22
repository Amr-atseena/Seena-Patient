//
//  UploadPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation

struct FileModel {
    var file : Data?
    var type : Int?
}

class UploadPresenter: UploadPresenterProtocol {
    // MARK: - Attributes
    weak var view: UploadViewProtocol?
    var interactor: UploadInputInteractorProtocol?
    var router: UploadRouterProtocol?
    let localization = UploadLocalization()
    private let documentType: Int
    var selectedImages = [FileModel]() {
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

    var docType: Int {
        return documentType
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
    func imageSelected(_ image: Data?, type: Int ) {
        guard let selectedImage = image  else {
            return
        }
        selectedImages.append(FileModel(file: selectedImage, type: type))
    }
    func config(UploadImageCell cell: UploadImageCellProtocol, atIndex index: Int) {
        let image = selectedImages[index]
        if image.type == 0 {
            cell.setImage(image.file!)
        }else{
            cell.setPDF()
        }
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
