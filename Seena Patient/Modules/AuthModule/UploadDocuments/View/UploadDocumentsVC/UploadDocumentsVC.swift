//
//  UploadDocumentsVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class UploadDocumentsVC: UIViewController, UploadDocumentsViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var uploadRequiredDocumentKeywordLabel: UILabel!
    @IBOutlet private var multipleFilesKeywordLabel: UILabel!
    @IBOutlet private var documentsTypeTableView: UITableView!
    @IBOutlet private var finishButton: UIButton!
    // MARK: - Attributes
    var presenter: UploadDocumentsPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: UploadDocumentsVC.className, bundle: nil)
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
        //uploadRequiredDocumentKeyword Label
        uploadRequiredDocumentKeywordLabel.text = presenter.localization.uploadRequireDoc
        uploadRequiredDocumentKeywordLabel.font = DesignSystem.Typography.subHeading4.font
        //multipleFilesKeyword Label
        multipleFilesKeywordLabel.text = presenter.localization.multipleFilesIfNeeded
        multipleFilesKeywordLabel.font = DesignSystem.Typography.subHeading4.font
        //finish Button 
        finishButton.setTitle(presenter.localization.finish, for: .normal)
        finishButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font
    }
    func setupDocumentTypeTableView() {
        documentsTypeTableView.delegate = self
        documentsTypeTableView.dataSource = self
        documentsTypeTableView.register(cellWithClass: DocumentTypeCell.self)
    }
    func reloadDocumentsType() {
        documentsTypeTableView.reloadData()
    }
    func enableFinishButton() {
        finishButton.isUserInteractionEnabled = true
        finishButton.backgroundColor = DesignSystem.Colors.primaryActionBackground.color
    }
    func disableFinisButton() {
        finishButton.isUserInteractionEnabled = false
        finishButton.backgroundColor = DesignSystem.Colors.primaryBorder.color
    }
    // MARK: - Actions
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    @IBAction private func didTapFinishButton(_ sender: UIButton) {
        presenter.finishButtonTapped()
    }
    // MARK: - DeInit
    deinit {
         debugPrint(UploadDocumentsVC.className + "Release from Momery")
    }
}
// MARK: - TableView Data Soucrce Implementation
extension UploadDocumentsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfDocumentsType
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: DocumentTypeCell.self, for: indexPath)
        presenter.config(documentTypeCell: cell, atIndex: indexPath.row)
        return cell
    }
}
// MARK: - TableView Delegate Implementation
extension UploadDocumentsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.documentType(selectedAtIndex: indexPath.row)
    }
}
