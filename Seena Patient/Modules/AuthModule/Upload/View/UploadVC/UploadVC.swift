//
//  UploadVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import MobileCoreServices


class UploadVC: UIViewController, UploadViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var uploadKeywordLabel: UILabel!
    @IBOutlet private var uploadButton: UIButton!
    @IBOutlet private var finishButton: UIButton!
    @IBOutlet private var imagesCollectionView: UICollectionView!
    @IBOutlet private var loadingIndictor: UIActivityIndicatorView!
    @IBOutlet weak var uploadPdfBtn: UIButton!
    // MARK: - Attributes
    var presenter: UploadPresenterProtocol!
    var viewController : UIViewController?
    private lazy var imagePicker: ImagePicker = {
        return ImagePicker(presentationController: self, delegate: self)
    }()
    // MARK: - Init
    init() {
        super.init(nibName: UploadVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var fromImageOrFile = ""

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        uploadButton.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
        uploadPdfBtn.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)

        viewController?.hidesBottomBarWhenPushed = true

        uploadPdfBtn.setTitle("Upload pdf file".toLocalize, for: .normal)

        if presenter.docType == 2 || presenter.docType == 3 {
            uploadPdfBtn.isHidden = false
        }else{
            uploadPdfBtn.isHidden = true
        }
    }
    // MARK: - Methods
    func setupUI() {
        //uploadKeyword Label
        uploadKeywordLabel.text = presenter.localization.uploadDocs
        uploadKeywordLabel.font = DesignSystem.Typography.subHeading4.font
        //finish Button
        finishButton.setTitle(presenter.localization.finish, for: .normal)
        finishButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font
        //upload Button
        uploadButton.setTitle("Upload photo".toLocalize, for: .normal)
        uploadButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font

        uploadPdfBtn.titleLabel?.font = DesignSystem.Typography.subHeading3.font
    }
    func setupImagesCollectionView() {
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(cellWithClass: UploadImageCell.self)
    }
    func showLoadingIndictor() {
        loadingIndictor.startAnimating()
    }
    func hideLoadingIndictor() {
        loadingIndictor.stopAnimating()
    }
    func enableFinishButton() {
        finishButton.isUserInteractionEnabled = true
        finishButton.backgroundColor = DesignSystem.Colors.primaryActionBackground.color

        if fromImageOrFile == "imagee" {
            uploadButton.isUserInteractionEnabled = true
            uploadButton.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
            uploadPdfBtn.backgroundColor = .gray
            uploadPdfBtn.isUserInteractionEnabled = false
        }else if fromImageOrFile == "file"{
            uploadButton.isUserInteractionEnabled = false
            uploadPdfBtn.isUserInteractionEnabled = true
            uploadPdfBtn.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
            uploadButton.backgroundColor = .gray

        }else{
            uploadButton.isUserInteractionEnabled = true
            uploadPdfBtn.isUserInteractionEnabled = true
            uploadButton.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
            uploadPdfBtn.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)

        }

    }
    func disableFinishButton() {
        finishButton.isUserInteractionEnabled = false
        finishButton.backgroundColor = DesignSystem.Colors.primaryBorder.color

        uploadButton.isUserInteractionEnabled = true
        uploadPdfBtn.isUserInteractionEnabled = true

        uploadButton.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
        uploadPdfBtn.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)

        fromImageOrFile = ""
    }

    func disableButtonsWhilefinish(){
        uploadButton.isUserInteractionEnabled = false
        uploadPdfBtn.isUserInteractionEnabled = false
        uploadButton.backgroundColor = .gray

        if !uploadPdfBtn.isHidden {
        uploadPdfBtn.backgroundColor = .gray
        }else{
        }
    }

    func openImagePicker() {
        imagePicker.present(from: uploadButton)
    }
    func reoladImages() {
        imagesCollectionView.reloadData()
    }
    // MARK: - Actions
    @IBAction func didTapUploadButton(_ sender: UIButton) {
//        if presenter.docType == 0 {
//            if presenter.numberOfImages == 1 {
//                showAlertController(title: "Alert!".toLocalize, message: "You can only upload one image for profile picture".toLocalize, actions: [])
//            }else{
//                presenter.uploadButtonTapped()
//            }
//        }else{
            presenter.uploadButtonTapped()
//        }

    }
    @IBAction func didTapBackButton(_ sender: UIButton) {

            self.presenter.backButtonTapped()



    }
    @IBAction func didTapFinishButton(_ sender: UIButton) {
        let noAction = UIAlertAction(title: "No".localized, style: .default) {  (_) in
            self.presenter.finishButtonTapped()
        }
        let yesAction = UIAlertAction(title: "Yes".localized, style: .default, handler: nil)

        self.showAlertController(title: "Confirm!".toLocalize, message: "Would you like to change uploaded photo/s".toLocalize, actions: [noAction,yesAction])
    }
    // MARK: - DeInit
    deinit {
        debugPrint(UploadVC.className + " Release from Momery")
    }


//    var types = [kUTTypePDF,kUTTypePNG,kUTTypeJPEG,kUTTypeImage]
    var types = [kUTTypePDF]


    @IBAction func uploadPdf(_ sender: Any) {
//        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"] , in: .import)
        let documentPicker = UIDocumentPickerViewController(documentTypes: types as [String] , in: .import)

        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)

    }




}
// MARK: - ImagePickerDelegate Implementation
extension UploadVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        fromImageOrFile = "imagee"

        presenter.imageSelected((image?.jpegData(compressionQuality: 0.5)), type: 0)
        
    }
}
// MARK: - Images CollectionView DataSource
extension UploadVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfImages
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: UploadImageCell.self, for: indexPath)
        presenter.config(UploadImageCell: cell, atIndex: indexPath.item)
        cell.deleteImage = { [weak self] in
            guard  let self = self else { return}
            self.presenter.deleteImageButtonTapped(atIndex: indexPath.item)
        }
        return cell
    }
}
// MARK: - Images CollectionView Delegate
extension UploadVC: UICollectionViewDelegate {
}
// MARK: - Images CollectionView FlowLayout
extension UploadVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width  - 20) / 2
        let height: CGFloat = 150
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  5.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


extension UploadVC: UIDocumentPickerDelegate,UINavigationControllerDelegate
{
    //MARK: Document Picker Delegate
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

        /* Picker pick the specified Document and Given output as URL format */

        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")


        do{
            fromImageOrFile = "file"

            let fileData = try Data(contentsOf: myURL)
            print(fileData)

            let res = try myURL.resourceValues(forKeys: [.fileSizeKey])
            let filesize = res.fileSize!
            print("\(filesize) MB")

            if filesize >= 4000000 {
                showAlertController(title: "Error!".toLocalize, message: "File size is too big, please select another file".toLocalize, actions: [])
            }else{
                presenter.imageSelected(fileData, type: 1)

            }

        }catch{
            print("No file data")
        }
        
//        var filePath = urls[0].absoluteString
//        filePath = filePath.replacingOccurrences(of: "file:/", with: "")//making url to file path
//        print(filePath)


    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {

        // Picker Cancelled
        print("view was cancelled")
        controller.dismiss(animated: true, completion: nil)
    }


}
