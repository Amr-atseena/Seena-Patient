//
//  ClinicsSearchVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ClinicsSearchVC: UIViewController, ClinicsSearchViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var resultsKeyordLabel: UILabel!
    @IBOutlet private var searchTextFiled: UITextField!
    @IBOutlet private var noResultsView: UIView!
    @IBOutlet private var noResultsHeaderKeywordLabel: UILabel!
    @IBOutlet private var noResultsbodyKeywordLabel: UILabel!
    @IBOutlet private var clinicsResultsTableView: UITableView!
    // MARK: - Attributes
    var presenter: ClinicsSearchPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: ClinicsSearchVC.className, bundle: nil)
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
    // MARK: - Methods
    func setupUI() {
        // results keyword Label
        resultsKeyordLabel.text = presenter.localization.results
        resultsKeyordLabel.textColor = DesignSystem.Colors.secondaryText.color
        resultsKeyordLabel.font = DesignSystem.Typography.title1.font
        // search textFiled
        searchTextFiled.placeholder = presenter.localization.searchPlaceholder
        searchTextFiled.textColor = DesignSystem.Colors.primaryText.color
        searchTextFiled.tintColor = DesignSystem.Colors.primaryText.color
        searchTextFiled.font = DesignSystem.Typography.title2.font
        searchTextFiled.becomeFirstResponder()
        // noResultsHeaderKeyword Label
        noResultsHeaderKeywordLabel.text = presenter.localization.noResultsHeaderKeyword
        noResultsHeaderKeywordLabel.textColor = DesignSystem.Colors.primaryText.color
        noResultsHeaderKeywordLabel.font = DesignSystem.Typography.title2.font
        // noResultsbodyKeyword Label
        noResultsbodyKeywordLabel.text = presenter.localization.noResultsbodyKeyword
        noResultsbodyKeywordLabel.textColor = DesignSystem.Colors.primaryText.color
        noResultsbodyKeywordLabel.font = DesignSystem.Typography.title2.font
    }
    func setupClinicsTableView() {
        clinicsResultsTableView.delegate = self
        clinicsResultsTableView.dataSource = self
        clinicsResultsTableView.register(cellWithClass: ClinicCell.self)
    }
    func reloadClinicsTableView() {
        clinicsResultsTableView.reloadData()
    }
    func showSkelton() {
        noResultsView.isHidden = true
    }
    func hideSkelton() {
    }
    // MARK: - Actions
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    @IBAction private func didTapSerachButton(_ sender: UIButton) {
        presenter.searchButtonTapped(withKeyword: searchTextFiled.text)
    }
    // MARK: - DeInit
    deinit {
         debugPrint(ClinicsSearchVC.className + " Release from Momery")
    }
}

// MARK: - ClinicsSearch TableView DataSource
extension ClinicsSearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfClinics
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ClinicCell.self, for: indexPath)
        return cell
    }
}
// MARK: - ClinicsSearch TableView Delegate
extension ClinicsSearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.clinicsResultsTableView(selectedAtIndex: indexPath.row)
    }
}
