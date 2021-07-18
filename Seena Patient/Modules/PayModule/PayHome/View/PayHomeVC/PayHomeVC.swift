//
//  PayHomeVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 06/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import MOLH

class PayHomeVC: UIViewController, PayHomeViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var loadingIndictor: UIActivityIndicatorView!
    @IBOutlet private var noDataView: UIView!
    @IBOutlet private var yourBalanceKeywordLabel: UILabel!
    @IBOutlet private var youPayKeywordLabel: UILabel!
    @IBOutlet private var amountPayedLabel: UILabel!
    @IBOutlet private var dueAmountLabel: UILabel!
    @IBOutlet private var availableBalanceLabel: UILabel!
    @IBOutlet private var availableBalanceKeywordLabel: UILabel!
    @IBOutlet private var paymentsDueKeywordLabel: UILabel!
    @IBOutlet private var payLabel: UILabel!
    @IBOutlet private var calculatorLabel: UILabel!
    @IBOutlet private var paymentsDueTableView: UITableView!
    @IBOutlet private var progressView: MKMagneticProgress!

    @IBOutlet weak var getYourSeenaView: UIView!

    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var youHaveLbl: UILabel!
    @IBOutlet weak var getYourSeenaImage: UIImageView!

    @IBOutlet weak var allFilterBtn: UIButton!
    @IBOutlet weak var paidFilterBtn: UIButton!
    @IBOutlet weak var unpaidFilterBtn: UIButton!
    @IBOutlet weak var pendingFilterBtn: UIButton!
    @IBOutlet weak var rejectedFilterBtn: UIButton!





    // MARK: - Attributes
    var presenter: PayHomePresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: PayHomeVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()


        applyBtn.layer.cornerRadius = 10
        allFilterBtn.layer.cornerRadius = 10
        paidFilterBtn.layer.cornerRadius = 10
        unpaidFilterBtn.layer.cornerRadius = 10
        pendingFilterBtn.layer.cornerRadius = 10
        rejectedFilterBtn.layer.cornerRadius = 10

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        tabBarController?.tabBar.isHidden = false
    }
    // MARK: - Methods
    func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setupUI() {
        // yourBalanceKeyword Label
        yourBalanceKeywordLabel.text = presenter.localization.yourBalance
        yourBalanceKeywordLabel.font = DesignSystem.Typography.heading.font
        // youPayKeyword Label
        youPayKeywordLabel.text = presenter.localization.youPaid
            youPayKeywordLabel.font =  DesignSystem.Typography.subHeading4.font
        // availableBalanceKeyword Label
        availableBalanceKeywordLabel.text = presenter.localization.availableBalance
        availableBalanceKeywordLabel.font = AppResources.fonts.seena(styleForEnglish: .bold(20), styleForArabic: .bold(28))
        // amountPayed Label
        amountPayedLabel.font = DesignSystem.Typography.subHeading2.font
        // dueAmount Label
        dueAmountLabel.font = DesignSystem.Typography.subHeading4.font
        // pay Label
        payLabel.font = DesignSystem.Typography.subHeading3.font
        payLabel.text = presenter.localization.pay
        // calculate Label
        calculatorLabel.font = DesignSystem.Typography.subHeading3.font
        calculatorLabel.text = presenter.localization.calculate
        // paymentsDueKeyword Label
        paymentsDueKeywordLabel.font = DesignSystem.Typography.subHeading2.font
        paymentsDueKeywordLabel.text = presenter.localization.paymentsDue
        // availableBalance Label
        availableBalanceLabel.font = DesignSystem.Typography.subHeading2.font
    }
    func setupPaymentsDueTableView() {
        paymentsDueTableView.dataSource = self
        paymentsDueTableView.delegate = self
        paymentsDueTableView.register(cellWithClass: DueCell.self)
    }
    func setPaymentProgress(totalAmount: String, paidAmount: String, avaliableBalance: String, ratio: Double) {
        amountPayedLabel.text = paidAmount
        dueAmountLabel.text = totalAmount
        availableBalanceLabel.text = avaliableBalance
        progressView.setProgress(progress: CGFloat(ratio), animated: true)

    }
    func realodDue() {
        paymentsDueTableView.reloadData()
    }
    func showNoDataView() {
        noDataView.isHidden = false
    }
    func hideNoDataView() {
        noDataView.isHidden = true
    }
    func showPaymentDue() {
        paymentsDueTableView.isHidden = false
    }
    func hidePaymentDue() {
        paymentsDueTableView.isHidden = true
    }
    func showLoadingIndictor() {
        loadingIndictor.startAnimating()
    }
    func hideLoadingIndictor() {
        loadingIndictor.stopAnimating()
    }
    func showGetYourSeenaView(){
        getYourSeenaView.isHidden = false

        if MOLHLanguage.isArabic() {
            getYourSeenaImage.image = UIImage(named: "freeCreditAr")
        }else{
            getYourSeenaImage.image = UIImage(named: "freeCredit")
        }


        let signed = UserDefaults.standard.bool(forKey: "Signin")

        let token = UserDefaults.standard.string(forKey: "TOKEN")
        if signed == false {
            applyBtn.isUserInteractionEnabled = false
                        applyBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                        youHaveLbl.isHidden = false
            youHaveLbl.text = "Please sign in".toLocalize
        }else{
            applyBtn.isUserInteractionEnabled = true
                       applyBtn.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
                       youHaveLbl.isHidden = true
        }
//        if !tokkkk {
//            applyBtn.isUserInteractionEnabled = true
//                       applyBtn.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
//                       youHaveLbl.isHidden = true
//        }else{
//            applyBtn.isUserInteractionEnabled = false
//                        applyBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//                        youHaveLbl.isHidden = false
//        }

//        let userToken = UserDefaults.standard.string(forKey: "firstSignUpToken")
//        if userToken == nil{
//        applyBtn.isUserInteractionEnabled = false
//            applyBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//            youHaveLbl.isHidden = false
//        }else{
//            applyBtn.isUserInteractionEnabled = true
//            applyBtn.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
//            youHaveLbl.isHidden = true
//        }
    }
    func hideGetYourSeenaView(){
        getYourSeenaView.isHidden = true
    }
    func showProgressView(){
        progressView.isHidden = false
    }
    func hideProgressView(){
        progressView.isHidden = true
    }


    @IBAction func all(_ sender: Any) {
        print("All")
        paymentsDueTableView.reloadData()
    }

    @IBAction func paid(_ sender: Any) {
        print("paid")
    }

    @IBAction func unpaid(_ sender: Any) {
        print("unpaid")
    }

    @IBAction func pending(_ sender: Any) {
        print("pending")
    }

    @IBAction func rejected(_ sender: Any) {
        print("rejected")
    }

    var sendProfile: Bool?
    var sendID: Bool?
    var sendFin: Bool?
    var sendRes:Bool?


    // MARK: - Actions

    @IBAction func apply(_ sender: Any) {




                    let isID = UserDefaults.standard.bool(forKey: "idType")
                    let isIDLogin = UserDefaults.standard.bool(forKey: "idTypeLogin")
                    let isFin = UserDefaults.standard.bool(forKey: "financialProof")
                    let isFinLogin = UserDefaults.standard.bool(forKey: "financialProofLogin")
                    let isProfile = UserDefaults.standard.bool(forKey: "profilePicture")
                    let isProfileLogin = UserDefaults.standard.bool(forKey: "profilePictureLogin")
                    let isRes = UserDefaults.standard.bool(forKey: "residenceProof")
                    let isResLogin = UserDefaults.standard.bool(forKey: "residenceProofLogin")


                    if isID == true || isIDLogin == true {
                        self.sendID = true
                    }else{
                        self.sendID = false
                    }

                    if isProfile == true || isProfileLogin == true{
                        self.sendProfile = true
                    }else{
                        self.sendProfile = false
                    }

                    if isRes == true || isResLogin == true{
                        self.sendRes = true
                    }else{
                        self.sendRes = false
                    }

                    if isFin == true || isFinLogin == true{
                        self.sendFin = true
                    }else{
                        self.sendFin = false
                    }

                    let status = Status(profilePicture: self.sendProfile ?? false, idType: self.sendID ?? false, financialProof: self.sendFin ?? false, residenceProof: self.sendRes ?? false)
                    let router = UploadDocumentsRouter()
                    let interactor = UploadDocumentsInteractor()
                    let vc = UploadDocumentsVC()
                    let presenter = UploadDocumentsPresenter(view: vc, interactor: interactor, router: router, status: status)

                    router.viewController = vc
                    interactor.presenter = presenter
                    vc.presenter = presenter
                    self.navigationController?.pushViewController(vc, animated: true)








//        let storyBoard: UIStoryboard = UIStoryboard(name: "SecondSignUp", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CompleteSignStageOneViewController") as? CompleteSignStageOneViewController
//        newViewController!.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(newViewController!, animated: true)
//        newViewController!.modalPresentationStyle = .fullScreen
//        self.present(newViewController!, animated: true, completion: nil)
    }



    @IBAction private func didTapPayButton(_ sender: UIButton) {
        presenter.payButtonTapped()
    }
    @IBAction private func didTapCalculateButton(_ sender: UIButton) {
//        presenter.calculateButtonTapped()
    }
    // MARK: - DeInit
    deinit {
         debugPrint(PayHomeVC.className + " Release from Momery")
    }
}
// MARK: - tableView DataSource Impelementations
extension PayHomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfDue
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: DueCell.self, for: indexPath)
        presenter.config(dueCell: cell, atIndex: indexPath.row)
        return cell
    }
}
// MARK: - tableView Delegate Impelementations
extension PayHomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.dueCell(selectedAtIndex: indexPath.row)
    }
}


//extension PayHomeVC: HomeOutputInteractorProtocol {
//    func onRetriveUserSuccess(withUser user: User?) {
//        guard let user = user else {
//            getYourSeenaView.isHidden = false
//            progressView.isHidden = true
//            return
//        }
//        progressView.isHidden = false
//        getYourSeenaView.isHidden = true
//    }
//
//    func onRetriveDataSuccess(with homeServices: HomeResponse) {
////        view?.hideSkeltonView()
////        specialities = homeServices.specialities
////        packages = homeServices.packages
//    }
//    func onRetriveDataFail() {
////        view?.hideSkeltonView()
//    }
//}
