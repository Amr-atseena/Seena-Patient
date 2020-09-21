//
//  TransactionsVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class TransactionsVC: UIViewController, TransactionsViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var transactionsKeywordLabel: UILabel!
    @IBOutlet private var transactionsTableView: UITableView!
    // MARK: - Attributes
    var presenter: TransactionsPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: TransactionsVC.className, bundle: nil)
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
    func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setupUI() {
        // transactionsKeyword Label
        transactionsKeywordLabel.text = presenter.localization.transactions
        transactionsKeywordLabel.font = DesignSystem.Typography.heading.font
    }
    func setupTransactionsTableView() {
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        transactionsTableView.register(cellWithClass: TransactionCell.self)
    }
    func reloadTransactions() {
        transactionsTableView.reloadData()
    }
    // MARK: - Actions
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    // MARK: - DeInit
    deinit {
         debugPrint(TransactionsVC.className + " Release from Momery")
    }
}
// MARK: - TransactionsTableView DataSource Implementation
extension TransactionsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TransactionCell.self, for: indexPath)
        return cell
    }
}
// MARK: - TransactionsTableView Delegate Implementation
extension TransactionsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
