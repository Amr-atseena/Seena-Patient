//
//  ClinicsHomeVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import SkeletonView
class ClinicsHomeVC: UIViewController, ClinicsHomeViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var clinicsKeywordLabel: UILabel!
    @IBOutlet private var searchTextField: UITextField!
    @IBOutlet private var clinicsTableView: UITableView!
    // MARK: - Attributes
    lazy var clincOfWeek = ClinicOfTheWeekHeaderView()
    var presenter: ClinicsHomePresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: ClinicsHomeVC.className, bundle: nil)
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
        // search textFiled
        searchTextField.placeholder = presenter.localization.searchPlaceholder
        searchTextField.textColor = DesignSystem.Colors.primaryText.color
        searchTextField.font = DesignSystem.Typography.title2.font
        // clinics Keyword Label
        clinicsKeywordLabel.text = presenter.localization.clinics
        clinicsKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        clinicsKeywordLabel.font = DesignSystem.Typography.heading.font
        setupClinicOfTheWeekView()
    }
    func setupNavBar(withTitle title: String) {
        navigationController?.navigationBar.isHidden = true
    }
    func setupClinicOfTheWeekView() {
        clincOfWeek.didTapClinicOfTheWeeekButton = { [weak self] in
            guard let self = self else { return }
            self.presenter.clinicOfWeekButtonTapped()
        }
        clincOfWeek.didTapCallButton = { [weak self] in
            guard let self = self else { return }
            self.presenter.callButtonTapped()
        }
    }
    func setupClinicsTableView() {
        clinicsTableView.delegate = self
        clinicsTableView.dataSource = self
        clinicsTableView.register(cellWithClass: ClinicCell.self)
        clinicsTableView.register(cellWithClass: ClinicsSectionHeaderCell.self)
        clinicsTableView.register(cellWithClass: ClinicSkeletonCell.self)
        clinicsTableView.tableHeaderView = clincOfWeek
        clinicsTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 50))
    }
    func setClinicOfTheWeek(_ clinic: ClinicViewModel) {
        clincOfWeek.setClinicOfTheWeek(clinic)
    }
    func reloadClinics() {
        clinicsTableView.reloadData()
    }
    func showClinicOfThWeek() {
//        clinicsTableView.tableHeaderView = clincOfWeek
    }
    func hideClinicOfTheWeek() {
        clinicsTableView.tableHeaderView = nil
    }
    func showSkeleton() {
        clincOfWeek.showSkeleton()
        clinicsTableView.showAnimatedGradientSkeleton()
    }
    func hideSkeleton() {
        clincOfWeek.hideSkeleton()
        clinicsTableView.hideSkeleton()
    }
    // MARK: - Actions

    @IBAction private func didTapSearchButton(_ sender: UIButton) {
        presenter.searchButtonTapped()
    }
    // MARK: - DeInit
    deinit {
        debugPrint(ClinicsHomeVC.className + " Release from Momery")
    }
}
// MARK: - Clinics DataSource Implementation
extension ClinicsHomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfClincs(inSection: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ClinicCell.self, for: indexPath)
        presenter.config(ClinicCell: cell, atIndex: indexPath.row, andSection: indexPath.section)
        cell.callButtonTapped = { [weak self] in
            guard let self = self else {return}
            self.presenter.callButtonTapped(atSection: indexPath.section, andIndex: indexPath.row)
        }
        return cell
    }
}
// MARK: - Clinics Delegate Implementation
extension ClinicsHomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.clinicTableView(selectedAtIndex: indexPath.row, andSection: indexPath.section)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withClass: ClinicsSectionHeaderCell.self, for: IndexPath(item: 0, section: section))
        presenter.config(headerCell: header, atSection: section)
        header.seeAllButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.presenter.seeAllButtonTapped(atSection: section)
        }
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
// MARK: - SkeletonTableViewDataSource Implementaion
extension ClinicsHomeVC: SkeletonTableViewDataSource, SkeletonTableViewDelegate {
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ClinicSkeletonCell.className
    }
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }
}
