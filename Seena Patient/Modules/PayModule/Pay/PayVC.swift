//
//  PayVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PayVC: UIViewController, PayViewProtocol, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // MARK: - Outlets
    @IBOutlet weak var uploadRecBtn: UIButton!
    @IBOutlet private var paymentKeywordLabel: UILabel!
    @IBOutlet private var bankImage: UIImageView!
    @IBOutlet private var accountNumberKeywordLabel: UILabel!
    @IBOutlet private var accountNumberLabel: UILabel!
    @IBOutlet private var nextButton: UIButton!
    @IBOutlet private var transactionIdTextFiled: UITextField!
    @IBOutlet private var loadingIndicotor: UIActivityIndicatorView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var rightImage: UIImageView!
    // MARK: - Attributes
    var presenter: PayPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: PayVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    // MARK: - Methods
    func setupUI() {
        // paymentKeyword Label
        paymentKeywordLabel.text = presenter.localization.payment
        paymentKeywordLabel.font = DesignSystem.Typography.heading.font
        // accountNumberKeyword Label
        accountNumberKeywordLabel.font = DesignSystem.Typography.subHeading3.font
        accountNumberKeywordLabel.text = presenter.localization.accountNumber
        // accountNumber Label
        accountNumberLabel.font = DesignSystem.Typography.title3.font
        nextButton.setTitle(presenter.localization.next, for: .normal)
        nextButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font
        //  transactionId TextFiled
        transactionIdTextFiled.placeholder = presenter.localization.receiptReference
    }
    func setAccount(image: String, accountName: String, accountNumber: String) {
        bankImage.kf.setImage(with: URL(string: image))
        accountNumberKeywordLabel.text = accountName
        accountNumberLabel.text = accountNumber
    }
    func enableNextButton() {
        nextButton.backgroundColor = DesignSystem.Colors.primaryActionBackground.color
        nextButton.isUserInteractionEnabled = true
    }
    func disableNextButton() {
        nextButton.backgroundColor = DesignSystem.Colors.primaryBorder.color
        nextButton.isUserInteractionEnabled = false
    }
    func showLoadingIndicotor() {
        loadingIndicotor.startAnimating()
    }
    func hideLoadingIndictor() {
        loadingIndicotor.stopAnimating()
    }


    @IBAction func uploadReceipt(_ sender: Any) {
        let picker = UIImagePickerController()
                picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
                picker.allowsEditing = false
                self.present(picker, animated: true) {
                }

    }

    var uploadedImage : UIImage?
    let progressHUD = ProgressHUD(text: "")
    weak var viewController: UIViewController?

    // MARK: - Actions
    @IBAction private func didNextButtonTapped(_ sender: UIButton) {

        let instID = UserDefaults.standard.string(forKey: "installmentId")
        let payMeth = UserDefaults.standard.string(forKey: "insType")
        let idd = UserDefaults.standard.string(forKey: "insID")

        let payyy = PayParams(image: uploadedImage, installmentId: Int(instID!), paymentMethod: Int(payMeth!), id: Int(idd!))

        self.view.addSubview(progressHUD)

        APIClient().uploadReceptCall(payParams: payyy) { (res) in
            self.progressHUD.removeFromSuperview()

            print(res)
            self.presenter.nextButtonTapped(withTransactionId: "")

        } onError: { (error) in
            self.progressHUD.removeFromSuperview()
            self.showAlertController(title: "Error!", message: error, actions: [])
        }



//        presenter.nextButtonTapped(withTransactionId: transactionIdTextFiled.text)


    }

    private func navigateToPaymentSuccess(withPayment payment: Payment) {
        let payment = PaymentSuccessRouter.assembleModule(withPayment: payment)
        viewController?.navigationController?.pushViewController(payment, animated: true)
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage

        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }

        // do something interesting here!
        print(newImage)
        uploadedImage = newImage
        infoBtn.isHidden = true
        rightImage.isHidden = false
        enableNextButton()

        dismiss(animated: true)
    }










    @IBAction private func didBackButtonTapped(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    @IBAction private func didInfoButtonTapped(_ sender: UIButton) {
        presenter.infoButtonTapped()
    }
    @IBAction private func didTranactionTextFieldEditChange(_ sender: UITextField) {
        presenter.transactionIdEditChange(transactionId: sender.text)
    }
    // MARK: - DeInit
    deinit {
         debugPrint(PayVC.className + "Release from Momery")
    }
}
