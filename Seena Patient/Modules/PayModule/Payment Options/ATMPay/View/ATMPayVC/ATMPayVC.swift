//
//  ATMPayVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ATMPayVC: UIViewController, ATMPayViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var accountsCollectionView: UICollectionView!
    @IBOutlet private var nextButton: UIButton!
    @IBOutlet private var messageLabel: UILabel!
    // MARK: - Attributes
    var presenter: ATMPayPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: ATMPayVC.className, bundle: nil)
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
        // next Button
        nextButton.setTitle(presenter.localization.next, for: .normal)
        nextButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font
        // next Button
        messageLabel.text = presenter.localization.payMessage
        messageLabel.font = DesignSystem.Typography.title2.font
    }
    func setupBankAccountsCollectionView() {
        self.accountsCollectionView.delegate = self
        self.accountsCollectionView.dataSource = self
        accountsCollectionView.register(cellWithClass: PayOptionCell.self)
    }
    func enableNextButton() {
        nextButton.backgroundColor = DesignSystem.Colors.primaryActionBackground.color
        nextButton.isUserInteractionEnabled = true
    }
    // MARK: - Actions
    @IBAction private func didNextButtonTapped(_ sender: UIButton) {
        presenter.nextButtonTapped()
    }
    // MARK: - DeInit
    deinit {
        debugPrint(ATMPayVC.className + "Release from Momery")
    }
}
// MARK: - ClinicsCollectionView DataSoucrce Implementation
extension ATMPayVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfAccounts
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: PayOptionCell.self, for: indexPath)
        presenter.config(payCell: cell, atIndex: indexPath.item)
        return cell
    }
}
// MARK: - clinicsCollectionView Delegate Implementation
extension ATMPayVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.payOption(selectedAtIndex: indexPath.item)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        presenter.payOption(deSelectedAtIndex: indexPath.item)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = false
    }
}

// MARK: - clinicsCollectionView FlowLayoutDelegate Implementation
extension ATMPayVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width  - 30) / 1.1
        let height = (collectionView.frame.size.height)
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  5.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
