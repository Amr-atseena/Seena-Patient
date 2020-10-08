//
//  PayHomeVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 06/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PayHomeVC: UIViewController, PayHomeViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var loadingIndictor: UIActivityIndicatorView!
    @IBOutlet private var noDataView: UIView!
    @IBOutlet private var yourBalanceKeywordLabel: UILabel!
    @IBOutlet private var youPayKeywordLabel: UILabel!
    @IBOutlet private var amountPayedLabel: UILabel!
    @IBOutlet private var dueAmountLabel: UILabel!
    @IBOutlet private var paymentsDueKeywordLabel: UILabel!
    @IBOutlet private var payLabel: UILabel!
    @IBOutlet private var calculatorLabel: UILabel!
    @IBOutlet private var paymentsDueTableView: UITableView!
    @IBOutlet private var progressView: MKMagneticProgress!
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
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
    }
    func setupPaymentsDueTableView() {
        paymentsDueTableView.dataSource = self
        paymentsDueTableView.delegate = self
        paymentsDueTableView.register(cellWithClass: DueCell.self)
    }
    func setPaymentProgress(totalAmount: String, paidAmount: String, ratio: Double) {
        amountPayedLabel.text = paidAmount
        dueAmountLabel.text = totalAmount
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
    // MARK: - Actions
    @IBAction private func didTapPayButton(_ sender: UIButton) {
        presenter.payButtonTapped()
    }
    @IBAction private func didTapCalculateButton(_ sender: UIButton) {
        presenter.calculateButtonTapped()
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
        return cell
    }
}
// MARK: - tableView Delegate Impelementations
extension PayHomeVC: UITableViewDelegate {
}
