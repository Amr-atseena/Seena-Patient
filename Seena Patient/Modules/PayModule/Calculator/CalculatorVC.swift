//
//  CalculatorVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 09/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController, CalculatorViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var calculateKeywordLabel: UILabel!
    @IBOutlet private var findOutKeywordLabel: UILabel!
    @IBOutlet private var bodyKeywordLabel: UILabel!
    @IBOutlet private var plansTableView: UITableView!
    // MARK: - Attributes
    var presenter: CalculatorPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: CalculatorVC.className, bundle: nil)
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
        // calculateKeyword Label
        calculateKeywordLabel.text = presenter.localization.calculator
        calculateKeywordLabel.font = DesignSystem.Typography.heading.font
        // findOutKeyword Label
        findOutKeywordLabel.text = presenter.localization.findOut
        findOutKeywordLabel.font = DesignSystem.Typography.subHeading3.font
        // bodyKeyword Label
        bodyKeywordLabel.text = presenter.localization.body
        bodyKeywordLabel.font = DesignSystem.Typography.title3.font        
    }
    func setupPlansTableView() {
        plansTableView.dataSource = self
        plansTableView.register(cellWithClass: PlanCell.self)
    }
    func reloadPlans() {
        plansTableView.reloadData()
    }
    // MARK: - Actions
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    @IBAction private func didAmountEditChange(_ sender: UITextField) {
        presenter.amountValueChange(sender.text)
    }
    // MARK: - DeInit
    deinit {
         debugPrint(CalculatorVC.className + "Release from Momery")
    }
}

extension CalculatorVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPlans
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: PlanCell.self, for: indexPath)
        presenter.config(planCell: cell, atIndex: indexPath.row)
        return cell
    }
}

extension CalculatorVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 8
    }

}
