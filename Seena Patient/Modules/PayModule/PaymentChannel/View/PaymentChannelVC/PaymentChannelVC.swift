//
//  PaymentChannelVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 07/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PaymentChannelVC: UIViewController, PaymentChannelViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var paymentChannelKeywordLabel: UILabel!
    @IBOutlet private var paymentMethodsTableView: UITableView!
    @IBOutlet var containerView: UIView!
    // MARK: - Attributes
    var presenter: PaymentChannelPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: PaymentChannelVC.className, bundle: nil)
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
        tabBarController?.tabBar.isHidden = true
    }
    // MARK: - Methods
    func setupNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    func setupUI() {
        // paymentChannelKeyword Label
        paymentChannelKeywordLabel.text = presenter.localization.paymentChannel
        paymentChannelKeywordLabel.font = DesignSystem.Typography.heading.font
    }
    func setupPaymentMethodsTableView() {
        paymentMethodsTableView.delegate = self
        paymentMethodsTableView.dataSource = self
        paymentMethodsTableView.register(cellWithClass: PaymentMethodCell.self)
    }
    func reloadPaymentMethods() {
        paymentMethodsTableView.reloadData()
    }
    // MARK: - Actions
    @IBAction private func didBackButtonTapped(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    // MARK: - DeInit
    deinit {
         debugPrint(PaymentChannelVC.className + " Release from Momery")
    }
}
// MARK: - tableView DataSource Impelementations
extension PaymentChannelVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: PaymentMethodCell.self, for: indexPath)
        presenter.config(paymentCell: cell, atIndex: indexPath.row)
        return cell
    }
}
// MARK: - tableView Delegate Impelementations
extension PaymentChannelVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.option(selectedAtIndex: indexPath.row)
    }
}
