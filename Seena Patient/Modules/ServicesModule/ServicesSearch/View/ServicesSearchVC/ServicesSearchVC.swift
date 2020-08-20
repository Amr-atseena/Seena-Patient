//
//  ServicesSearchVC.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/17/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ServicesSearchVC: UIViewController, ServicesSearchViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var resultsKeyordLabel: UILabel!
    @IBOutlet private var searchTextFiled: UITextField!
    @IBOutlet private var noResultsView: UIView!
    @IBOutlet private var noResultsHeaderKeywordLabel: UILabel!
    @IBOutlet private var noResultsbodyKeywordLabel: UILabel!
    @IBOutlet private var servicesResultsTableView: UITableView!
    // MARK: - Attributes
    var presenter: ServicesSearchPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: ServicesSearchVC.className, bundle: nil)
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
    func setupServicesTableView() {
        servicesResultsTableView.delegate = self
        servicesResultsTableView.dataSource = self
        servicesResultsTableView.register(cellWithClass: ServiceResultCell.self)
    }
    func reloadServicesTableView() {
        servicesResultsTableView.reloadData()
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
         debugPrint(ServicesSearchVC.className + "Release from Momery")
    }
}
// MARK: - ServicesResults TableView DataSource
extension ServicesSearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfService
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ServiceResultCell.self, for: indexPath)
        return cell
    }
}
// MARK: - ServicesResults TableView Delegate
extension ServicesSearchVC: UITableViewDelegate {
}
